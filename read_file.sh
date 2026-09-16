#!/usr/bin/env bash

FILENAME="my_file.txt"

# The canonical way to read a file line by line
while IFS= read -r line; do
    echo "LINE: $line"
done < "$FILENAME"

