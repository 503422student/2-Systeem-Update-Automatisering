#!/bin/bash
date

# Execute the hostnamectl command and store the output in the 'output' variable
output=$(hostnamectl)

# Search for the line that starts with "Operating System"
os_line=$(echo "$output" | grep "Operating System")

# Extract the OS name and version using awk and remove the LTS information
os_info=$(echo "$os_line" | awk -F ': ' '{print $2}' | cut -d ' ' -f1,2)

# Convert the OS name to lowercase for case-insensitive comparison
os_name=$(echo "$os_info" | awk '{print tolower($0)}')

# Check if the OS info was found
if [ -n "$os_name" ]; then
    echo "Operating System: $os_info"
else
    echo "Operating System not found."
    exit 1
fi

# Check if the OS name is "ubuntu" (case-insensitive comparison)
if [ "$os_name" == "ubuntu" ]; then
    echo "Detected Ubuntu, running apt update and upgrade commands"
    apt update
    apt upgrade -y
fi

# Check if the OS name is "fedora" (case-insensitive comparison)
if [ "$os_name" == "fedora" ]; then
    echo "Detected Fedora, running dnf commands"
    dnf upgrade -y
fi

# Check if the OS name is "centos" (case-insensitive comparison)
if [ "$os_name" == "centos" ]; then
    centos_version=$(echo "$os_info" | awk '{print $2}' | cut -d '.' -f1)
    
    if [ "$centos_version" -le 7 ]; then
        echo "Detected CentOS $centos_version, running yum update commands"
        yum update -y
    else
        echo "Detected CentOS $centos_version or newer, running dnf upgrade commands"
        dnf upgrade -y
    fi
fi
