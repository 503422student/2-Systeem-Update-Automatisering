#!/bin/bash

# Execute the hostnamectl command and store the output in the 'output' variable
output=$(hostnamectl)

# Search for the line that starts with "Operating System"
os_line=$(echo "$output" | grep "Operating System")

# Extract the OS name using awk
os_name=$(echo "$os_line" | awk -F ': ' '{print $2}')

# Check if the OS name was found
if [ -n "$os_name" ]; then
    echo "Operating System: $os_name"
else
    echo "Operating System not found."
fi
