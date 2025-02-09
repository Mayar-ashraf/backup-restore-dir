.PHONY: create_dest_backup backupd restore 
BACKUP_SCRIPT = ./backupd.sh
RESTORE_SCRIPT = ./restore.sh
SOURCE_DIR = SourceDir
BACKUP_DIR = BackupDir
SECS = 30
MAX_BACKUPS = 3

all: create_backup_dir backupd 

backupd: create_backup_dir 
	@bash $(BACKUP_SCRIPT) $(SOURCE_DIR) $(BACKUP_DIR) $(SECS) $(MAX_BACKUPS) 

create_backup_dir:
	@if [ ! -d $(BACKUP_DIR) ]; then \
		 mkdir -p $(BACKUP_DIR); \
                 echo "Backup directory is ready: ./$(BACKUP_DIR)"; \
        fi

restore: 
	@bash $(RESTORE_SCRIPT) $(SOURCE_DIR) $(BACKUP_DIR)


