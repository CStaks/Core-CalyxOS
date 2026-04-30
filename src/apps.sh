# this script sets up the apps

#!/bin/bash

set -e

echo "Installing KDE Plasma, Brave, Kitty..."

# Update repos
sudo apt update && sudo apt upgrade -y

# Install KDE Plasma (simple and clean DE)
sudo apt install -y kde-plasma-desktop kde-plasma-workspace

# add Brave repo for brave browser
curl https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key add -
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update

# Install Brave and Kitty
sudo apt install -y brave-browser kitty

# set defaults
sudo update-alternatives --install /usr/bin/x-www-browser x-www-browser /usr/bin/brave-browser 100
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/bin/kitty 100

echo "Apps installed"
