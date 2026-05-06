#  DHCP Obfuscator: A Network Identity Anonymizer

[![License](https://img.shields.io/badge/License-See_File-blue.svg)](https://github.com/gekko4/dhcp-obfuscator/blob/master/LICENSE)
![Language](https://img.shields.io/badge/Language-Bash-green.svg)
![Dependencies](https://img.shields.io/badge/Dependencies-nmcli%20%7C%20figlet-orange.svg)

DHCP Obfuscator is a lightweight, interactive utility to anonymize your network footprint by stripping identifiable metadata from your DHCP requests. 

> **Note:** We are starting with **Linux** for this script. If you are on **Windows** or **macOS**, scroll down to the [Alternatives for macOS & Windows](#alternatives-for-macos--windows) section at the bottom to see how you can achieve similar privacy protections!

---

##  Overview

When you connect to a network, your device leaks metadata by default. Network administrators and eavesdroppers can see your device's original MAC address, hostname, operating system details, and client IDs.

This script hardens your connection by modifying your **NetworkManager** connection properties via `nmcli`. It prevents local networks (like public Wi-Fi, cafes, or hotel networks) from profiling your device.

###  Crucial Details You Should Know

1. **Profile Existence & Proximity:** You do not need to be actively connected when running the script, but you **must have connected to the network at least once in the past** so your system has a saved profile for it.
2. **Profile-Specific Permanence:** The obfuscation settings are **permanent for the specific network you target**. Every time you connect to that Wi-Fi network in the future, your identity will remain masked.

## Features

- **Randomized MAC Address**: Configures the connection to generate a *new*, random MAC address every single time you reconnect (`wifi.cloned-mac-address random`). 
  *(Note: Network switches and routers require a MAC address to successfully route traffic to your device, meaning it cannot simply be deleted or left completely blank. Constantly randomizing it ensures you cannot be tracked across sessions).*
- **Erased Hostname**: Prevents your device from broadcasting its hostname via DHCP Option 12 entirely.
- **Scrubbed Client ID**: Overrides identifiable DHCP Client IDs to generic MAC-based traces.
- **Ghost Vendor Class**: Injects a blank space into the Vendor Class Identifier (Option 60), hiding your OS and device type.
- **IPv6 Leak Protection**: Completely disables IPv6 for the target connection to prevent tracking via static IPv6 addresses.
- **Auto-Restart**: Automatically restarts the connection to immediately apply your new, spoofed network identity.


##  Prerequisites

Ensure you have the following installed on your Linux system:
- `nmcli` (NetworkManager Command Line Interface) - Usually pre-installed on most modern Linux distributions.
- `figlet` *(Optional)* - Used to generate the terminal banner. (`sudo apt-get install figlet`)

##  Installation

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

##  Usage

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

##  Alternatives for macOS & Windows

Because this script relies entirely on `nmcli` (NetworkManager), it is **strictly for Linux** and cannot be run on macOS or Windows. 

While you cannot easily get the "full package" of per-network DHCP scrubbing (like entirely erasing hostnames, overriding Vendor Class Identifiers, or custom Client IDs) on these operating systems without advanced third-party tools, you can manually reproduce some of the core features:

###  Windows
*   **MAC Randomization:** Windows 10 and 11 have this built-in! Go to **Settings > Network & Internet > Wi-Fi** and toggle on **Random hardware addresses**.
*   **Hostname Blending:** Unlike Linux (where we can erase the broadcast completely), Windows *will* broadcast your PC name to the network. To protect your identity, you must globally rename your PC to something generic to blend in (e.g., `DESKTOP-12345`) via **System Properties**.
*   **Disable IPv6:** Open **Network Connections**, right-click your Wi-Fi adapter, select **Properties**, and uncheck **Internet Protocol Version 6 (TCP/IPv6)**.

###  macOS
*   **MAC Spoofing:** Open the Terminal and temporarily spoof your MAC address using: `sudo ifconfig en0 ether <random_mac>` *(replace `en0` with your active adapter and `<random_mac>` with a randomly generated MAC address)*.
*   **Hostname Blending:** Similar to Windows, you cannot easily stop macOS from sending a hostname. Instead, change your global system name to something generic via Terminal: `sudo scutil --set HostName "Generic-Name"`.
*   **Disable IPv6:** Disable IPv6 for Wi-Fi via Terminal: `networksetup -setv6off Wi-Fi`.

##  License

This project is open-source. See the [LICENSE](LICENSE) file for more information.
