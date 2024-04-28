#!/bin/bash

LOG_FILE="script_executions.log"
echo "Script PID: $$" >> "$LOG_FILE"

echo "$(date) - ${USER} ran $0 with args: $0" >> "$LOG_FILE"

UUID_FILE="uuids.log"
LAST_UUID_FILE="last_uuid.log"


generate_uuid() {
  local N B T

  for (( N=0; N < 16; ++N )); do
    B=$(( $RANDOM%255 ))

    if (( N == 6 )); then
      printf '4%x' $(( B%15 ))
    elif (( N == 8 )); then
      local C='89ab'
      T=${C:$(( $RANDOM%${#C} )):1}
      printf '%s%x' $T $(( B%15 ))
    else
      printf '%02x' $B
    fi

    case $N in
      3|5|7|9)
        printf '-'
        ;;
    esac
  done

  printf '\n'
}

save_and_log_uuid() {
  UUID=$(generate_uuid)
  if grep -q $UUID "$UUID_FILE"; then
    echo "Collision detected: $UUID has already been generated."
    exit 1
  else
    echo $UUID >> "$UUID_FILE"
    echo $UUID > "$LAST_UUID_FILE"
    echo "$(date) - $UUID" >> "generation.log"
    echo "New UUID generated: $UUID"
  fi
}


categorize_content() {
  for dir in _Directory/*; do
    if [ -d "$dir" ]; then
      echo "Analyzing $dir:"
      declare -A count_types
      for file in "$dir"/*; do
        if [[ -f $file ]]; then
          extension="${file##*.}"
          let count_types[$extension]++
        fi
      done

      for type in "${!count_types[@]}"; do
  echo -n "Type .$type: "
  echo -n "${count_types[$type]} files, "

  # Execute find and awk in a subshell and capture the PID
  (find "$dir" -type f -name "*.$type" -exec du -ch {} + | awk '/total$/ {print $1}') &
  last_pid=$!
  echo "PID for find/awk subprocess handling files of type .$type in $dir: $last_pid" >> "$LOG_FILE"
done


      echo "Total space used in $dir: $(du -sh "$dir" | cut -f1)"

      shortest=$(find "$dir" -type f | awk -F/ '{print $NF}' | awk '{print length, $0}' | sort -n | head -1)
      largest=$(find "$dir" -type f | awk -F/ '{print $NF}' | awk '{print length, $0}' | sort -nr | head -1)
      echo "Shortest filename in $dir: ${shortest#* }"
      echo "Longest filename in $dir: ${largest#* }"
      echo
    fi
  done
}


case "$1" in
  --generate)
    save_and_log_uuid
    ;;
  --last)
    if [ -f "$LAST_UUID_FILE" ]; then
      cat "$LAST_UUID_FILE"
    else
      echo "No UUID has been generated yet."
    fi
    ;;
  --all)
    if [ -f "$UUID_FILE" ]; then
      cat "$UUID_FILE"
    else
      echo "No UUIDs have been generated yet."
    fi
    ;;
  --categorize)
    if [ -n "$2" ]; then
      categorize_content > "$2"
      echo "Categorization results are written to $2"
    else
      categorize_content
    fi
    ;;
  *)
    echo "Usage: $0 --generate | --last | --all | --categorize"
    exit 1
    ;;
esac

