#!/bin/bash
date

# Execute the hostnamectl command and store the output in the 'output' variable
output=$(hostnamectl)

# Search for the line that starts with "Operating System"
os_line=$(echo "$output" | grep "Operating System")

# Extract the OS name and version using awk and remove the LTS information
os_info=$(echo "$os_line" | awk -F ': ' '{print $2}' | sed 's/LTS//')

# Extract the OS name without the version information
os_name=$(echo "$os_info" | awk '{print $1}')

# Convert the OS name to lowercase for case-insensitive comparison
os_name_lowercase=$(echo "$os_name" | tr '[:upper:]' '[:lower:]')

# Check if the OS info was found
if [ -n "$os_name_lowercase" ]; then
    echo "Operating System: $os_info"
else
    echo "Operating System not found."
    exit 1
fi

# Check if the OS name is "ubuntu" (case-insensitive comparison)
if [ "$os_name_lowercase" == "ubuntu" ]; then
    echo "Detected Ubuntu, running apt update and upgrade commands"
    apt update
    apt upgrade -y
fi

# Check if the OS name is "fedora" (case-insensitive comparison)
if [ "$os_name_lowercase" == "fedora" ]; then
    echo "Detected Fedora, running dnf commands"
    dnf upgrade -y
fi

# Check if the OS name is "centos" (case-insensitive comparison)
if [ "$os_name_lowercase" == "centos" ]; then
    centos_version=$(echo "$os_info" | awk '{print $2}' | cut -d '.' -f1)
    
    if [ "$centos_version" -le 7 ]; then
        echo "Detected CentOS $centos_version, running yum update commands"
        yum update -y
    else
        echo "Detected CentOS $centos_version or newer, running dnf upgrade commands"
        dnf upgrade -y
    fi
fi
