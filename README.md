# 🕵️‍♂️ DHCP Obfuscator: Network Identity Anonymizer on Linux

[![License](https://img.shields.io/badge/License-See_File-blue.svg)](https://github.com/gekko4/dhcp-obfuscator/blob/master/LICENSE)
![Language](https://img.shields.io/badge/Language-Bash-green.svg)
![Dependencies](https://img.shields.io/badge/Dependencies-nmcli%20%7C%20figlet-orange.svg)

DHCP Obfuscator is a lightweight, interactive Linux utility to anonymize your network footprint by stripping identifiable metadata from your DHCP requests.

---

## 📖 Overview

When you connect to a network, your device leaks metadata by default. Network administrators and eavesdroppers can see your device's original MAC address, hostname, operating system details, and client ID. 

This script hardens your connection by modifying your **NetworkManager** connection properties via `nmcli`. It prevents local networks (like public Wi-Fi, cafes, or hotel networks) from profiling your device.

### ⚠️ Crucial Details You Should Know

1. **Profile Existence & Proximity:** You do not need to be actively connected when running the script, but you **must have connected to the network at least once in the past** so your system has a saved profile for it. You also need to be **physically in range** of the network, otherwise the script's auto-restart step will fail to connect.
2. **Profile-Specific Permanence:** The obfuscation settings are **permanent for the specific network you target**. Every time you connect to that Wi-Fi network in the future, your identity will remain hidden. It does *not* apply globally; you must run this script for each new Wi-Fi network you want to anonymize.

## Features

- **Randomized MAC Address**: Configures the connection to generate a *new*, random MAC address every single time you reconnect (`wifi.cloned-mac-address random`). 
  *(Note: Network switches and routers require a MAC address to successfully route traffic to your device, meaning it cannot simply be deleted or left completely blank. Constantly randomizing it ensures anonymity while maintaining a working internet connection.)*
- **Erased Hostname**: Prevents your device from broadcasting its hostname via DHCP Option 12.
- **Scrubbed Client ID**: Overrides identifiable DHCP Client IDs to generic MAC-based traces.
- **Ghost Vendor Class**: Injects a blank space into the Vendor Class Identifier (Option 60), hiding your OS and device type.
- **IPv6 Leak Protection**: Completely disables IPv6 for the target connection to prevent tracking via static IPv6 addresses.
- **Auto-Restart**: Automatically restarts the connection to immediately apply your new, spoofed network identity.


## 📋 Prerequisites

Ensure you have the following installed on your Linux system:
- `nmcli` (NetworkManager Command Line Interface) - Usually pre-installed on most modern Linux distributions.
- `figlet` *(Optional)* - Used to generate the terminal banner. (`sudo apt-get install figlet`)

## 🛠️ Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/gekko4/dhcp-obfuscator.git
   ```

2. **Navigate into the directory:**
   You **must** be inside the newly created directory for the following commands to work.
   ```bash
   cd dhcp-obfuscator
   ```

3. **Make the script executable:**
   *(Ensure you are still inside the `dhcp-obfuscator` directory)*
   ```bash
   chmod +x dhcp-obfuscator.sh
   ```

## 💻 Usage

You can run this script locally from the cloned directory, or install it globally for convenience.

### Option 1: Run Locally
*(Ensure you are currently inside the `dhcp-obfuscator` directory)*

Execute the script directly using `./` to tell your terminal to look in the current folder:
```bash
./dhcp-obfuscator.sh
```

### Option 2: Install Globally (Optional)
*(Ensure you are currently inside the `dhcp-obfuscator` directory)*

If you want to run the script from anywhere on your system without needing to navigate to this folder, copy it to your local bin:
```bash
sudo cp dhcp-obfuscator.sh /usr/local/bin/dhcp-obfuscator
```
Once copied, you can simply type this from *any* terminal location:
```bash
dhcp-obfuscator
```

### Next Steps (For either option):
The script will prompt you for the name of the Wi-Fi or Ethernet connection profile.
```text
Enter the Wi-Fi Connection Name (e.g., Gekko4):
```
*Tip: If you aren't sure of the exact name, open a new terminal tab and type `nmcli connection show` to list your saved networks.*

<img width="1376" height="840" alt="image" src="https://github.com/user-attachments/assets/e7757a09-5d09-40f2-9bdb-37ec6eb2fcd8" />

Done!


## 📄 License

This project is open-source. See the [LICENSE](LICENSE) file for more information.
