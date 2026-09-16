#!/usr/bin/env bash
declare -A arr=( [server0]="10.0.2.2" [server1]="10.0.3.3" [DB]="20.0.0.2" )

echo "number of elements = ${#arr} False "
echo "number of elements = ${#arr[@]} True "
echo "The value of element 2 = ${arr[server1]} "

keys=("${!arr[@]}")
echo "The key of element 0 = ${keys[0]}"
echo "The key of element 1 = ${keys[1]}"
echo "The key of element 2 = ${keys[2]}"
