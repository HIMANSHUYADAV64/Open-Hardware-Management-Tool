

# **Open Hardware Monitoring System**

A Linux-based system monitoring tool that provides real-time insights into CPU, GPU, memory, disk, network, and system processes. This shell script offers an intuitive menu-driven interface to monitor, manage, and optimize your system's performance.

---

## **Features**

- **CPU and GPU Monitoring**: Real-time usage, temperatures, and fan speeds.
- **Memory and Disk Usage**: Monitor RAM and disk space utilization.
- **Process Management**: View and kill resource-intensive processes.
- **Installed Applications**: List all installed applications.
- **Network Statistics**: Display live data speeds and interface statuses.
- **User-friendly Interface**: Menu-driven design for ease of use.

---



## **Getting Started**

### **Prerequisites**
Ensure you have the following installed:
- `lm-sensors`
- `nvidia-smi` (for NVIDIA GPUs)
- `iostat`
- `psensor`
- `ifconfig`

To install the required tools:
```bash
sudo apt-get install lm-sensors sysstat nvidia-utils ifconfig
```

### **Installation**
1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/open-hardware-monitor.git
   cd open-hardware-monitor
   ```

2. Make the script executable:
   ```bash
   chmod +x hardware_monitor.sh
   ```

3. Run the script:
   ```bash
   ./hardware_monitor.sh
   ```

---

## **How to Use**

1. Run the script using `./hardware_monitor.sh`.
2. Select an option from the menu to view specific system metrics or manage processes.
3. Exit the application by selecting the exit option.

---

## **Project Scope**

This project aims to simplify system monitoring for Linux users by integrating various command-line utilities into a single script. It provides insights into hardware performance and assists in resource management.

---

## **Contributing**

Contributions are welcome! If you'd like to contribute:
1. Fork the repository.
2. Create a feature branch (`git checkout -b feature-name`).
3. Commit your changes (`git commit -m "Add new feature"`).
4. Push to the branch (`git push origin feature-name`).
5. Open a pull request.

---

## **License**

This project is licensed under the MIT License. See the [LICENSE](./LICENSE) file for details.

---

## **Acknowledgments**

- **Linux Community**: For providing detailed documentation on system monitoring tools.
- **Contributors**: Everyone who helped test and improve the project.

---
![Screenshot 2024-11-28 205413](https://github.com/user-attachments/assets/9db25695-0367-47d6-893a-049f03ec6247)


