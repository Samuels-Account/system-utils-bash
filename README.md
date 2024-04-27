# UUID Generator Utility Script

The `uuid_generator` is a versatile Bash script designed for system administrators to manage and monitor IT infrastructure efficiently. It facilitates the generation of UUIDs without relying on built-in system utilities, categorizes directory contents, and maintains robust logging for system activities and audits.

## Features

- **UUID Generation**: Generates UUIDs pseudo-randomly to ensure uniqueness and checks for collisions with previously generated UUIDs.
- **Directory Analysis**: Analyzes and categorizes files within specified directories, reporting on file types, sizes, and identifying the shortest and longest filenames.
- **Logging**: Maintains detailed logs of UUID generation and script execution, aiding in system monitoring and audit trails.

## Usage

To use the script, run it from the command line with the desired options:

```bash
./uuid_generator.sh --option
```

### Options

- `--generate`: Generates a new UUID and logs the event.
- `--last`: Displays the last generated UUID.
- `--all`: Lists all generated UUIDs.
- `--categorize [output_file]`: Categorizes directory contents and outputs the results.

### Examples

- Generate a UUID and log the event:
  ```bash
  uuid_generator --generate
  ```

- Display the last generated UUID:
  ```bash
  uuid_generator --last
  ```

- List all UUIDs:
  ```bash
  uuid_generator --all
  ```

- Categorize directory contents and output to a file:
  ```bash
  uuid_generator --categorize output.txt
  ```

## Files

- `uuids.log`: Stores all generated UUIDs and timestamps.
- `last_uuid.log`: Contains the most recently generated UUID.
- `generation.log`: Logs details of each UUID generation.
- `script_executions.log`: Records each execution of the script.




# Initial Instructions - NOS_Assignment

## Important

**Do not** edit then content of the following unless instructed too: 
- `setup/`
- _Directory/  (Once it has been created, see Instructions)
 
## Instructions

The first thing you need to do is create the content needed for the assignment that deals with running checks on file storage. 

Run the command below to build the directory investigation part of the assignment :

```sh
$ bash setup/buildAssignment 
```


If by some mistake you delete, move or replace any of the content in `_Directory` you can run the bash script as follows:

```sh
$ bash setup/buildAssignment 
```

### _Directory
 
The `_Directory` folder will not be tacked by default. 

This is where you need to point your solution to analyse the contents as part of your assessment.

## Your Tasks
 
**Summary** 

1. Develop as bash ultilty script in current directory that:
    - Can generate two different versions of UUID{1,2,3,4,5} without the use of built-in UUID generators:
        - Should be able to save to file AND print to terminal.
        - Check if previous UUID exists and see if collision
        - Check when last UUID was generated
    - Categorise content in `_Directory`:
        - For each child directory report how many of each file type there and collective size of each file type
        - For each child directory specify total space used, in human readable format
        - For each child directory report find shortest and largest length of file name
        - Output results to file AND option to return to terminal
    - For all functionality
      - there should be an argument 
      - can run functionality per argument(s)
      - Must be able to record who has logged into system and when, and which script commands have been supplied appended to a log file. 
2. Build a simple `man` page for your script
    -  ensure you have compressed the document and named it with the correct `man` identifier.
3. Throughout ensure you have reference to the PID of your script and PID of any sub commands run!
4. You are encouraged to develop your solutions in a branch off of `main` and make merges where appropriate. **No** penalisation for developing in `main`.
