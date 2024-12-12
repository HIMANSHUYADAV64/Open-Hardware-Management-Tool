#!/bin/bash

# Function to check and install required tools
check_and_install_dependencies() {
    echo "Checking for required tools..."
    REQUIRED=("psensor" "vnstat" "iostat")
    for tool in "${REQUIRED[@]}"; do
        if ! command -v $tool &> /dev/null; then
            echo "$tool is not installed. Installing now..."
            sudo apt update && sudo apt install -y $tool
            echo "$tool installed successfully."
        else
            echo "$tool is already installed."
        fi
    done
}

# Detect hardware sensors
sensors_detect() {
    echo "Detecting hardware sensors..."
    sudo sensors-detect --auto
    echo "Sensor detection completed!"
}

# CPU configuration and temperature
cpu_sensors() {
    echo "=== CPU Configuration and Specs ==="
    lscpu
    echo "=== CPU Temperatures ==="
    sensors | grep -E "Core|Package|temp" || echo "Temperature data not available."
}

# Disk I/O stats
disk_io() {
    echo "=== Disk I/O Stats ==="
    iostat -xz 1 5
}

# Disk space usage
disk_usage() {
    echo "=== Disk Usage ==="
    psensor
}

# Real-time process monitoring with kill option
process_monitor() {
    echo "=== Top 20 Processes by CPU Usage ==="
    ps aux --sort=-%cpu | head -n 20

    read -p "Would you like to kill a process? (y/n): " choice
    if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
        read -p "Enter the PID of the process to kill: " pid
        if kill -9 $pid 2>/dev/null; then
            echo "Process $pid has been killed successfully."
        else
            echo "Failed to kill process $pid. Ensure you entered the correct PID."
        fi
    else
        echo "Returning to the menu."
    fi
}

# Network live speed monitoring
network_stats() {
    echo "=== Real-Time Network Statistics ==="
    echo "Interface | Received (KB/s) | Transmitted (KB/s)"
    while :; do
        awk '/:/ {if (NR > 2) {split($1, iface, ":"); rx[$1] = $2; tx[$1] = $10;}} END {
            for (i in rx) printf "%-12s | %-14d | %d KB/s\n", iface[1], rx[i]/1024, tx[i]/1024;
        }' /proc/net/dev
        sleep 1
    done
}

# GPU configuration and utilization
gpu_conf() {
    echo "=== GPU Configuration and Specs ==="
    lspci | grep -i vga
    echo "=== GPU Utilization (if available) ==="
    nvidia-smi || echo "NVIDIA GPU utility not installed or supported."
}

# Fan speed and temperature monitoring
fan_speed() {
    echo "=== Fan Speeds and Temperatures ==="
    sensors || echo "Fan speed and temperature data not available on this system."
}

# User information
user_info() {
    echo "=== User Information ==="
    whoami
    echo "=== Logged-in Users ==="
    who
}

# List all installed applications
 installed_apps() {
    echo "=== All Installed Applications ==="
    echo "Press 'q' to exit the list at any time."
    dpkg-query -l | awk '{print $2}' | less
}

# Display menu
display_menu() {
    echo "======================================"
    echo "       Open Hardware Monitoring Tool"
    echo "       CODEX"
    echo "======================================"
    echo "This tool allows you to monitor system hardware in real-time."
    echo "======================================"
    echo "A. Detect Hardware Sensors"
    echo "B. CPU Configuration and Temperature"
    echo "C. GPU Configuration and Utilization"
    echo "D. Disk I/O Stats"
    echo "E. Disk Usage and cpu usages"
    echo "F. Top 20 Processes by CPU Usage (with Kill Option)"
    echo "G. Real-Time Network Speed"
    echo "H. Fan Speeds and Temperatures"
    echo "I. User Information"
    echo "J. Installed Applications"
    echo "L. Exit"
    echo "======================================"
}

# Main loop
check_and_install_dependencies
while true; do
    display_menu
    read -p "Select an option (A-L): " option

    case $option in
        A|a) sensors_detect ;;
        B|b) cpu_sensors ;;
        C|c) gpu_conf ;;
        D|d) disk_io ;;
        E|e) disk_usage ;;
        F|f) process_monitor ;;
        G|g) network_stats ;;
        H|h) fan_speed ;;
        I|i) user_info ;;
        J|j) installed_apps ;;
        L|l)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid option. Please try again."
            ;;
    esac

    echo "Press Enter to continue..."
    read
done
