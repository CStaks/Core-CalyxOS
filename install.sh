#!/bin/bash


# not to be confused with setup.sh, this file installs git and clones the repository

set -e

echo "CalyxOS Huron Bootstrap"
echo "======================="

# Install git
echo "Installing git..."
sudo apt update
sudo apt install -y git

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
