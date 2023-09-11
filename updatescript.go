package main

import (
	"fmt"
	"os"
	"strings"
	"time"
)

func main() {
	// Find the current date and time
	currentTime := time.Now()
	fmt.Println("Current Date and Time:", currentTime.Format("2006-01-02 15:04:05"))

	// Find the current timezone
	timezone, err := time.LoadLocation("")
	if err != nil {
		fmt.Println("Error:", err)
	} else {
		zoneName, _ := currentTime.In(timezone).Zone()
		fmt.Println("Current Timezone:", zoneName)
	}

	// Find the Linux distribution
	linuxDistro, err := getLinuxDistro()
	if err != nil {
		fmt.Println("Error:", err)
	} else {
		fmt.Println("Linux Distribution:", linuxDistro)
	}
}

func getLinuxDistro() (string, error) {
	// Open the /etc/os-release file
	file, err := os.Open("/etc/os-release")
	if err != nil {
		return "", err
	}
	defer file.Close()

	// Create a buffer to store file contents
	buf := make([]byte, 1024)

	// Read the file contents into the buffer
	n, err := file.Read(buf)
	if err != nil {
		return "", err
	}

	// Convert the buffer to a string
	fileContents := string(buf[:n])

	// Split the file contents into lines
	lines := strings.Split(fileContents, "\n")

	// Search for the distribution name in the lines
	for _, line := range lines {
		if strings.HasPrefix(line, "PRETTY_NAME=") {
			// Extract the distribution name
			distro := strings.TrimPrefix(line, "PRETTY_NAME=")
			distro = strings.Trim(distro, "\"")

			// Split the distribution string by space and return the first part
			parts := strings.Split(distro, " ")
			if len(parts) > 0 {
				return parts[0], nil
			}
		}
	}

	return "", fmt.Errorf("Distribution name not found")
}
