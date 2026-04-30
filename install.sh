#!/bin/bash


# not to be confused with setup.sh, this file installs git and clones the repository

set -e

echo "CalyxOS Huron Bootstrap"
echo "======================="
while true; do sudo -n true; sleep 60; kill -0 $$ 2>/dev/null || exit; done &

# Install git and curl (curl is needed for the other scripts to properly work)
echo "Installing dependencies..."
sudo apt update -y
sudo apt install -y git curl gnupg

# Clone repo
echo "Cloning CalyxOS repository..."
git clone https://github.com/CStaks/Core-CalyxOS.git
cd Core-CalyxOS

# Make scripts executable
echo "Setting up scripts..."
chmod +x setup.sh
chmod +x src/*.sh

# Run setup
echo "Running CalyxOS setup..."
sudo bash ./setup.sh
