#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
NC='\033[0m'

if [ -d "$PREFIX" ] && [ "$PREFIX" = "/data/data/com.termux/files/usr" ]; then
    TERMUX=true
    echo -e "${CYAN}• Detected Termux environment.${NC}"
else
    TERMUX=false
    echo -e "${CYAN}• Detected Linux environment.${NC}"
fi

echo -e "${YELLOW}• Updating package lists...${NC}"
if $TERMUX; then
    pkg update -y && pkg upgrade -y
    pkg install python python-pip git figlet -y
else
    apt update -y && apt upgrade -y
    apt install python3 python3-pip git figlet -y
fi

if ! command -v pip3 &> /dev/null; then
    echo -e "${YELLOW}• pip3 not found, trying to install it...${NC}"
    if $TERMUX; then
        pkg install python-pip -y
    else
        apt install python3-pip -y
    fi

    if ! command -v pip3 &> /dev/null; then
        echo -e "${RED}✖ Failed to install pip3. Install pip manually...${NC}"
        curl -sS https://bootstrap.pypa.io/get-pip.py -o get-pip.py
        python3 get-pip.py
        rm get-pip.py
    fi
fi

if ! command -v pip3 &> /dev/null; then
    echo -e "${RED}✖ pip could not be installed. Check your environment.${NC}"
    exit 1
else
    echo -e "${GREEN}✔ pip3 successfully installed.${NC}"
fi

echo -e "${YELLOW}• Installing Python libraries...${NC}"
pip3 install --upgrade pip
pip3 install rich requests python-whois dnspython pyfiglet

echo -e "${GREEN}✔ All dependencies installed successfully!${NC}"
echo -e "${CYAN}• You can run tools with commands:${NC} ${GREEN}python3 Xscanweb.py or make run${NC}"