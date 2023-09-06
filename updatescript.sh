#!/bin/bash

# Voer het hostnamectl-commando uit en sla de uitvoer op in de variabele 'output'
output=$(hostnamectl)

# Zoek de regel die begint met "Operating System"
os_line=$(echo "$output" | grep "Operating System")

# Controleer of de regel is gevonden
if [ -n "$os_line" ]; then
    echo "Besturingssysteem: $os_line"
else
    echo "Besturingssysteem niet gevonden."
fi

