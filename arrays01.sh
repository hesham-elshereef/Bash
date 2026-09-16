#!/usr/bin/env bash
# This is our list (array) of servers
servers=("web-01" "web-02" "db-01" "monitoring")
echo "The first server is: ${servers}"
echo "The database server is: ${servers[1]}"
echo "Total servers: ${#servers[@]}"
servers+=("new-server-04")
echo "Total servers after: ${#servers[@]}"
echo "The last server is: ${servers[4]}"
