#!/usr/bin/env bash

# --- 1. Unquoted $* ---
echo "--- 1. Unquoted \$* ---"
echo "Result: Arguments are split on spaces (WRONG)"
echo "Loop count depends on word-splitting"
for arg in $*; do
    echo "Argument: '$arg'"
done
echo ""

# --- 2. Quoted "$*" ---
echo "--- 2. Quoted \"\$*\" ---"
echo "Result: Loop runs 1 time (WRONG)"
echo "\"file 1.txt file 2.txt\" expands to ONE string: all args joined by spaces"
for arg in "$*"; do
    echo "Argument: '$arg'"
done
echo ""

# --- 3. Unquoted $@ ---
echo "--- 3. Unquoted \$@ ---"
echo "Result: Arguments are split on spaces (WRONG)"
echo "Same problem as \$*: word splitting"
for arg in $@; do
    echo "Argument: '$arg'"
done
echo ""

# --- 4. Quoted "$@" (Correct way) ---
echo "--- 4. Quoted \"\$@\" (Correct way) ---"
echo "Result: Loop runs once per REAL argument (CORRECT)"
echo "\"\$@\" preserves each argument as a separate item"
for arg in "$@"; do
    echo "Argument: '$arg'"
done

