# 🕵️‍♂️ DHCP Obfuscator: Network Identity Anonymizer

![License](https://img.shields.io/github/license/gekko4/dhcp-obfuscator)
![Shell Script](https://img.shields.io/badge/language-shell-green)
![Dependencies](https://img.shields.io/badge/dependencies-nmcli%20%7C%20figlet-blue)

**DHCP Obfuscator** is a lightweight, interactive Bash script designed to anonymize your network footprint. By modifying your NetworkManager connection properties via `nmcli`, it prevents network administrators and eavesdroppers from identifying your device on local networks (like public Wi-Fi) by stripping identifiable metadata from your DHCP requests.

---

<!-- IMAGE PLACEHOLDER: Place an animated GIF or a screenshot of the terminal here showing the script running (e.g., the cool figlet banner and the prompts). -->
*(Insert a screenshot of the script in action here: `![Demo](link_to_image.png)`)*

## 🚀 Features

When you connect to a network, your device leaks metadata by default. This script hardens your connection by applying the following privacy enhancements:

- 🔀 **Randomized MAC Address**: Automatically randomizes both Wi-Fi and Ethernet MAC addresses (`wifi.cloned-mac-address random`).
- 🛑 **Erased Hostname**: Prevents your device from broadcasting its hostname via DHCP Option 12.
- 🧹 **Scrubbed Client ID**: Overrides identifiable DHCP Client IDs to generic MAC-based traces.
- 👻 **Ghost Vendor Class**: Injects a blank space into the Vendor Class Identifier (Option 60), hiding your OS and device type.
- 🚫 **IPv6 Leak Protection**: Completely disables IPv6 for the target connection to prevent tracking via static IPv6 addresses.
- 🔄 **Auto-Restart**: Automatically restarts the connection to immediately apply the new, spoofed network identity.

## 📋 Prerequisites

Before using this script, ensure you have the following installed on your Linux system:

- `nmcli` (NetworkManager Command Line Interface) - Usually pre-installed on most modern Linux distributions.
- `figlet` *(Optional)* - Used to generate the cool terminal banner.

To install `figlet` on Debian/Ubuntu-based systems:
```bash
sudo apt-get install figlet
```

## 🛠️ Usage

1. **Clone the repository:**
   ```bash
   git clone https://github.com/gekko4/dhcp-obfuscator.git
   cd dhcp-obfuscator
   ```

2. **Make the script executable:**
   ```bash
   chmod +action dhcp-obfuscator.sh
   ```

3. **Run the script (as root/sudo if necessary for nmcli connection changes):**
   ```bash
   ./dhcp-obfuscator.sh
   ```

4. **Follow the on-screen prompt:**
   The script will ask you for the name of the Wi-Fi or Ethernet connection you want to anonymize.
   ```text
   Enter the Wi-Fi Connection Name (e.g., Gekko4):
   ```
   *Tip: You can list your active connections using `nmcli connection show`.*

<!-- IMAGE PLACEHOLDER: Place a screenshot here showing the "SUCCESS" output and the "New Fake Identity" MAC address. -->
*(Insert a screenshot of the successful spoofing output here)*

## ⚠️ Disclaimer

This tool is provided for educational and privacy-enhancing purposes only. Use it responsibly and only on networks where you are authorized to alter your connection properties.

## 📄 License

This project is open-source. See the [LICENSE](LICENSE) file for more information.
