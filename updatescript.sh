#!/bin/bash
date

# Execute the hostnamectl command and store the output in the 'output' variable
output=$(hostnamectl)

# Search for the line that starts with "Operating System"
os_line=$(echo "$output" | grep "Operating System")

# Extract the OS name using awk and remove the version and LTS information
os_name=$(echo "$os_line" | awk -F ': ' '{print $2}' | cut -d ' ' -f1)

# Check if the OS name was found
if [ -n "$os_name" ]; then
    echo "Operating System: $os_name"
else
    echo "Operating System not found."
    exit 1
fi

# Check if the OS name is "Ubuntu" (using double equals '==')
if [ "$os_name" == "Ubuntu" ]; then
    echo "Detected Ubuntu, running apt update and upgrade commands"
    apt update
    apt upgrade -y
fi
