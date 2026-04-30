#!/bin/bash

set -e

echo "Installing Plymouth boot splash..."

# Install Plymouth
sudo apt install -y plymouth plymouth-themes

# Install a minimal theme
sudo apt install -y plymouth-theme-ubuntu-text

# Set the theme
sudo plymouth-set-default-theme ubuntu-text

# Update initramfs
sudo update-initramfs -u

echo "Plymouth installed"
echo "reboot required to take effect"
