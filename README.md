```markdown
# DHCP Obfuscator

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Bash](https://img.shields.io/badge/Language-Bash-green.svg)]()
[![Platform: Linux](https://img.shields.io/badge/Platform-Linux-lightgrey.svg)]()

A lightweight, terminal-based Bash script designed to systematically hide your Linux device from network routers. It neutralizes network profiling on public or untrusted Wi-Fi by spoofing your hardware address and deeply scrubbing your DHCP fingerprints.

---

## Table of Contents
- [Why Use This?](#why-use-this)
- [Features & Technical Breakdown](#features--technical-breakdown)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [How to Revert Changes](#how-to-revert-changes)
- [Troubleshooting](#troubleshooting)
- [Disclaimer](#disclaimer)

---

## Why Use This?
When you connect to a Wi-Fi network, your device hands over a significant amount of identifying information to the router via DHCP requests. This usually includes your permanent hardware MAC address, your computer's hostname (e.g., `kyale-ParrotOS`), and your operating system's vendor class. Network administrators and captive portals use this data to track your physical device across different sessions, monitor your traffic, or enforce time limits. 

**DHCP Obfuscator** automates the process of blanking out or randomizing these identifiers, making your machine look like a completely new, anonymous device every time you connect.

## Features & Technical Breakdown
This script utilizes `nmcli` to modify the following connection parameters permanently for the specified network:

*   **MAC Randomization:** Spoofs your physical hardware ID (`wifi.cloned-mac-address random`, `ethernet.cloned-mac-address random`).
*   **Hostname Erasure (DHCP Option 12):** Stops your device from broadcasting its system name to the network (`ipv4.dhcp-send-hostname no`).
*   **Client ID Scrubbing:** Forces the DHCP client ID to match your new, randomized MAC address instead of a static identifier (`ipv4.dhcp-client-id mac`).
*   **Vendor Class Cloaking (DHCP Option 60):** Injects a blank string to hide your OS and network manager type (`ipv4.dhcp-vendor-class-identifier " "`).
*   **IPv6 Disabling:** Shuts down IPv6 completely for the target network to prevent secondary IP leakages (`ipv6.method disabled`).

## Prerequisites
This tool requires **NetworkManager** to function. It will not work on systems using `netctl` or `systemd-networkd`.

*   `network-manager` (Provides the required `nmcli` framework)
*   `figlet` (Optional: highly recommended for the terminal ASCII banner rendering)

*Tested successfully on: Parrot OS, Kali Linux, Debian, and Ubuntu.*

## Installation

1. **Clone the repository:**
   ```bash
   git clone [https://github.com/YOUR_USERNAME/dhcp-obfuscator.git](https://github.com/YOUR_USERNAME/dhcp-obfuscator.git)
   cd dhcp-obfuscator
   ```

2. **Make the script executable:**
   ```bash
   chmod +x dhcp-obfuscator.sh
   ```

3. **Install it to your binaries path** (This allows you to run the command from any directory):
   ```bash
   sudo mv dhcp-obfuscator.sh /usr/local/bin/dhcp-obfuscator
   ```

## Usage

Once installed, simply call the tool directly from your terminal:

```bash
dhcp-obfuscator
```

**Step-by-Step:**
1. The script will prompt you for the exact name of the connection you want to obfuscate (e.g., `Starbucks_WiFi`). 
   * *Tip: You can list all your saved connection names by running `nmcli connection show` in another terminal tab.*
2. Enter the connection name.
3. The script will apply the obfuscation parameters, bring the network interface down, and restart it with your new identity.

## How to Revert Changes

**Important:** Because `nmcli` saves connection profiles, these obfuscation settings are **permanent** for that specific Wi-Fi network, even after a reboot. 

If you use this on a home or work network and need to restore your original settings (e.g., to bypass a MAC whitelist), the cleanest and safest way is to delete the network profile and reconnect from scratch:
```bash
# 1. Delete the modified connection profile
nmcli connection delete "Your_Connection_Name"

# 2. Reconnect to the network normally via your GUI or terminal
```

## Troubleshooting

*   **"Error: You must enter a connection name"**
    *   You left the prompt blank. Run the script again and provide the exact SSID/Connection name.
*   **"[FAIL] Could not restart connection"**
    *   This usually means the connection name was misspelled or doesn't exist in your saved NetworkManager profiles. Run `nmcli connection show` to verify the exact spelling (it is case-sensitive).
*   **Command not found: dhcp-obfuscator**
    *   Ensure you successfully moved the script to `/usr/local/bin/` and that the directory is in your system's `$PATH`.

## Disclaimer

This tool is provided for educational, research, and personal privacy purposes only. The creator assumes no liability and is not responsible for any misuse or damage caused by this script. Do not use this tool on networks where you do not have explicit permission to obfuscate your traffic or bypass network management policies.
```
