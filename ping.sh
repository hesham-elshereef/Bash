#!/usr/bin/env bash
FILENAME="servers.txt"
while IFS= read -r line; do
  # Check 1: Skip empty lines (zero-length)
  if [[ -z "$line" ]]; then
    continue
  fi
  # Check 2: Skip lines starting with # (comments)
  # Using pattern matching inside [[ ... ]]
  if [[ "$line" == \#* ]]; then
    echo "Skipping comment: $line"
    continue
  fi
  # If we reach this point, it's a valid server entry
  echo "Pinging server: $line"
  ping -c 1 "$line"

  echo "-----------------------"
done < "$FILENAME"
