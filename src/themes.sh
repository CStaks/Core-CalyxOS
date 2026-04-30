#!/bin/bash

set -e

echo "Installing Materia KDE and Papirus icons..."

# Install Papirus icons
sudo apt install -y papirus-icon-theme

# Clone and install Materia KDE from repo (reproducible)
cd /tmp
if [ -d materia-kde ]; then
  sudo rm -rf materia-kde
fi

sudo git clone https://github.com/PapirusDevelopmentTeam/materia-kde.git
cd materia-kde
sudo ./install.sh
cd /tmp
sudo rm -rf materia-kde

echo "✓ Themes installed"
