#!/usr/bin/env bash

USER_ID=$(id -u)

# Check if user ID is NOT zero (i.e., not root)
if [ "$USER_ID" -ne 0 ]; then
    echo "Error: This script must be run as root."
    exit 1
fi

echo "Welcome, Administrator!"
