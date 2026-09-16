#!/usr/bin/env bash

# Get today's date
today=$(date +"%Y-%m-%d")
backup_dir="/tmp/backup-$today"

echo "Checking for directory: $backup_dir"

# Here is the decision logic
if [[ -d "$backup_dir" ]]; then
    # This block runs IF the condition is TRUE
    echo "Directory already exists. Nothing to do."
else
    # This block runs IF the condition is FALSE
    echo "Directory not found. Creating..."
    mkdir "$backup_dir"
    echo "Directory created successfully."
fi

