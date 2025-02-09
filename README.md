# **Backup and Restore**
## **Overview**

This project provides a bash-solution to backup and restore different versions of directories on Linux. 
- **Folder Hierarchy**
    ```
    project-root/
    ├── SourceDir/                   
    ├── BackupDir/                  
    ├── backupd.sh                   
    ├── restore.sh                  
    ├── directory-info.last          
    ├── directory-info.new                                
    └── Makefile
    ```

    - **`SourceDir/`**

        The directory where the original files and folders exits. 
        This is the source directory in which its files/folders will be backed up.

    - **`BackupDir/`**

       The directory where the backup folders will be saved.
       Each folder is named based on the time the backup occured.

    - **`backupd.sh`**

        A bash script that handles backing up new versions of the source directory to the backup directory.

        - **Parameters:**
          1. Source directory (corresponds to `SourceDir/`).
          2. Destination directory for the backup (corresponds to `BackupDir/`).
          3. Time of wait between each backup check.
          4. The maximum number of backup directories in the destination directory.

        If the source file is modified, its current version will be copied to  `BackupDir/<current-date>`, where `<current-date>` will have the format `YYYY-MM-DD-hh-mm-ss`.

    - **`restore.sh`**

        A bash script file that handles restoring older or newer versions from the backup directory to the source directory.

        - **Parameters:** 
        1. Source directory to be restored.
        2. Backup directory containing the backup folders.

        The script retrieves the latest backup date from `BackupDir/`, sorts the folders (based on `<current-date>`), and saves the latest date as `backup_timestamp` This refers to the current version of the source directory. 
        Users can navigate to previous or next versions using options.


    - **`directory-info.last`**

         This file lists the entries of a source directory and and displays the last modification time of every file. 
         Initially, it stores state of the `SourceDir/` before any backup. If a backup occurred, its content will be overwritten by `directory-info.new`

     - **`directory-info.new`**

          Siliar to the `directory-info.last`, but it's updates regularly to check is changes occured to the source directory.

          To implement this, the contents of `directory-info.last` file will be compared to the contents of `directory-info.new` file. If they differ, a backup occurs and contents of `directory-info.new` will be copied to `directory-info.last`. 

    - **`Makefile`**
          
          Runs the backup and restore scripts and provide the arguments, along with pre-build steps to create the backup directory if it doesn't exist.

## **Prerequisites**

1. **Download the project**
    - Download the project directory on your system.
2. **Install Required Tools**
    - Ensure you have the `make` command installed:
      ```bash
      sudo apt update
      sudo apt install make
      ```
3. **Navigate to the Project Directory**
    - To set up the environment:
      ```bash
      cd 8404-lab2
      ```

## **Step-by-step Instructions**

### Run the Backup Solution

1. Execute the following command: 

    ```bash
      make backupd
    ```

      - This will back up all the  contents of `SourceDir/` to the `BackupDir/` by default.
      - The backup occurs every 30 seconds, but only if updates are detected in `SourceDir/`.
      - To change  default settings, modify them in the `Makefile`.


### Run the Restore Solution

1. Execute the following command: 

    ```bash
      make restore
    ```

    - This restores the latest version from `BackupDir/` to `SourceDir/`.
    - Users can navigate through different backups using the following options:
      - **Move Backward**: Restores the most recent version prior to the current backup.
      - **Move Forward**: Restores the next available version..
      -  **Exit**: Exits the script.
    - To change the directories, modify them in the `Makefile`.

### Handling Absence of `BackupDir`

- If the `BackupDir/` directory is missing, the script will automatically create an new one.   

## Sample Run (suppose max-backups = 3 )
- **Backup Sample Run**


![Backup](https://github.com/user-attachments/assets/fa5216c2-80bd-4260-92d2-4d00efef71cf)


- **Restore Sample Run**


![Restore](https://github.com/user-attachments/assets/8c3229d7-322a-4f33-bf88-dfb261a41653)
