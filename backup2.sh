#!/usr/bin/env bash

today=$(date +"%Y-%m-%d")
backup_dir="/tmp/backup-$today"
source_file="/var/log/syslog"

# Check if backup directory exists
if [[ ! -d "$backup_dir" ]]; then
    echo "Directory $backup_dir not found. Creating..."
    mkdir "$backup_dir"
    echo "Directory created."
else
    echo "Directory $backup_dir already exists."
fi

# Check if source file exists AND is readable
if [[ ! -f "$source_file" || ! -r "$source_file" ]]; then
    echo "Error: Source file $source_file does not exist or is not readable."
    exit 1
fi

# Check if source file is empty
if [[ ! -s "$source_file" ]]; then
    echo "Warning: Source file $source_file is empty. Backing up anyway."
fi

cp "$source_file" "$backup_dir/syslog.bak"
echo "Backup of $source_file completed successfully to $backup_dir"

