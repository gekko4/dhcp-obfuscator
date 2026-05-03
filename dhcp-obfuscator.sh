#!/bin/bash

#  COLORS
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Clear the screen for a clean look
clear

# THE BANNER 
# Checks if figlet is installed to draw the art
if command -v figlet &> /dev/null; then
    echo -e "${RED}"
    figlet -f slant "DHCP OBFUSCATOR"
    echo -e "${NC}"
else
    echo -e "${RED}=================================================="
    echo -e "   DHCP OBFUSCATOR: NETWORK IDENTITY ANONYMIZER"
    echo -e "==================================================${NC}"
fi

echo -e "${YELLOW}:: DE-ANONYMIZING TRAFFIC PATTERNS ::${NC}"
echo ""

# 1. Ask for the Connection Name
# -e allows backspace to work properly in read
echo -e -n "${CYAN}Enter the Wi-Fi Connection Name (e.g., Gekko4): ${NC}"
read CON_NAME

# Check if input is empty
if [ -z "$CON_NAME" ]; then
    echo -e "${RED}[!] Error: You must enter a connection name.${NC}"
    exit 1
fi

echo ""
echo -e "${GREEN}[*] Targeting Network: $CON_NAME ${NC}"
echo "---------------------------------------------"

# 2. Randomize MAC
echo -e "${CYAN}[*] Randomizing Hardware ID (MAC)...${NC}"
nmcli connection modify "$CON_NAME" wifi.cloned-mac-address random
nmcli connection modify "$CON_NAME" ethernet.cloned-mac-address random

# 3. Kill Hostname
echo -e "${CYAN}[*] Erasing Hostname (Option 12)...${NC}"
nmcli connection modify "$CON_NAME" ipv4.dhcp-send-hostname no
nmcli connection modify "$CON_NAME" ipv6.dhcp-send-hostname no

# 4. Scrub Client ID
echo -e "${CYAN}[*] Scrubbing Client ID Traces...${NC}"
nmcli connection modify "$CON_NAME" ipv4.dhcp-client-id mac

# 5. Blank Vendor Class
echo -e "${CYAN}[*] Injecting 'Ghost' Vendor Class (Option 60)...${NC}"
nmcli connection modify "$CON_NAME" ipv4.dhcp-vendor-class-identifier " "

# 6. Disable IPv6
echo -e "${CYAN}[*] Disabling IPv6 Leaks...${NC}"
nmcli connection modify "$CON_NAME" ipv6.method disabled

# 7. Restart
echo "---------------------------------------------"
echo -e "${YELLOW}[*] Restarting Network Interface...${NC}"
nmcli connection down "$CON_NAME" > /dev/null 2>&1

if nmcli connection up "$CON_NAME" > /dev/null 2>&1; then
    echo ""
    echo -e "${GREEN}[SUCCESS] You are now invisible on '$CON_NAME'.${NC}"
    # Optional: Show the new spoofed MAC
    CURRENT_MAC=$(nmcli -f GENERAL.HWADDR dev show | head -n1 | awk '{print $2}')
    echo -e "${GREEN}[INFO] New Fake Identity: $CURRENT_MAC${NC}"
else
    echo ""
    echo -e "${RED}[FAIL] Could not restart connection. Check the name '$CON_NAME'.${NC}"
fi
