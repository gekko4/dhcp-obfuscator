# 🕵️‍♂️ DHCP Obfuscator: Network Identity Anonymizer

[![License](https://img.shields.io/badge/License-See_File-blue.svg)](https://github.com/gekko4/dhcp-obfuscator/blob/master/LICENSE)
![Language](https://img.shields.io/badge/Language-Bash-green.svg)
![Dependencies](https://img.shields.io/badge/Dependencies-nmcli%20%7C%20figlet-orange.svg)

DHCP Obfuscator is a lightweight, interactive Linux utility designed to anonymize your network footprint by stripping identifiable metadata from your DHCP requests.

---

<!-- IMAGE PLACEHOLDER: Place an animated GIF or a screenshot of the terminal here showing the script running -->
*(Insert a screenshot of the script in action here)*

## Overview

When you connect to a network, your device leaks metadata by default. Network administrators and eavesdroppers can see your device's original MAC address, hostname, operating system details, and client ID. 

This script hardens your connection by modifying your **NetworkManager** connection properties via `nmcli`. It prevents local networks (like public Wi-Fi, cafes, or hotel networks) from profiling your device.

### ⚠️ Crucial Details You Should Know

1. **You Must Connect First:** Because this script modifies an *existing* saved network profile, **you must connect to the target Wi-Fi network at least once normally** before running the script. This allows NetworkManager to create the connection profile that the script will then target and anonymize.
2. **Profile-Specific Permanence:** The obfuscation settings are **permanent for the specific network you target**. Every time you connect to that specific Wi-Fi network in the future, your identity will remain hidden. However, it does *not* apply globally. You must run this script for each new Wi-Fi network you want to be anonymous on.

## Features

- **Randomized MAC Address**: Configures both Wi-Fi and Ethernet MAC addresses to randomize upon connection (`wifi.cloned-mac-address random`).
- **Erased Hostname**: Prevents your device from broadcasting its hostname via DHCP Option 12.
- **Scrubbed Client ID**: Overrides identifiable DHCP Client IDs to generic MAC-based traces.
- **Ghost Vendor Class**: Injects a blank space into the Vendor Class Identifier (Option 60), hiding your OS and device type.
- **IPv6 Leak Protection**: Completely disables IPv6 for the target connection to prevent tracking via static IPv6 addresses.
- **Auto-Restart**: Automatically restarts the connection to immediately apply your new, spoofed network identity.

## Prerequisites

Ensure you have the following installed on your Linux system:
- `nmcli` (NetworkManager Command Line Interface) - Usually pre-installed on most modern Linux distributions.
- `figlet` *(Optional)* - Used to generate the terminal banner. (`sudo apt-get install figlet`)

## Installation & Setup (Global Access)

To make the script easily accessible from anywhere on your system (so you don't have to navigate to the folder every time you join a new Wi-Fi), you can add it to your local user binary directory.

1. **Clone the repository:**
   ```bash
   git clone https://github.com/gekko4/dhcp-obfuscator.git
   cd dhcp-obfuscator
   ```

2. **Make the script executable:**
   ```bash
   chmod +x dhcp-obfuscator.sh
   ```

3. **Install to your local bin (Recommended):**
   Copy the script to `/usr/local/bin` so it can be executed as a standard command from any terminal directory.
   ```bash
   sudo cp dhcp-obfuscator.sh /usr/local/bin/dhcp-obfuscator
   ```

## Usage

1. **Connect to the target Wi-Fi network.** (This ensures the connection profile exists).
2. **Run the tool from your terminal:**
   ```bash
   # If you installed it to /usr/local/bin:
   sudo dhcp-obfuscator
   
   # Or if running locally from the cloned folder:
   sudo ./dhcp-obfuscator.sh
   ```
   *(Note: `sudo` is often required because changing NetworkManager connection properties requires administrative privileges).*

3. **Enter the Connection Name:**
   The script will prompt you for the name of the Wi-Fi or Ethernet connection profile.
   ```text
   Enter the Wi-Fi Connection Name (e.g., Gekko4):
   ```
   *Tip: If you aren't sure of the exact name, open a new terminal tab and type `nmcli connection show` to list your saved networks.*

<!-- IMAGE PLACEHOLDER: Place a screenshot here showing the "SUCCESS" output -->
*(Insert a screenshot of the successful spoofing output here)*

## License

This project is open-source. See the [LICENSE](LICENSE) file for more information.
