#!/usr/bin/env bash
LOG_DIR="/var/log/my-app"
FOUND_FILE=""

for log_file in "$LOG_DIR"/*.log; 
do
    echo "Scanning file: $log_file"
    if grep -q "FATAL_ERROR" "$log_file"; then
        echo "Found error in: $log_file"
        FOUND_FILE="$log_file"
        break
    fi
done

if [ -n "$FOUND_FILE" ]; then
    echo "The first corrupted file is: $FOUND_FILE"
    # You can send an email or alert here
else
    echo "No corrupted files found."
fi

