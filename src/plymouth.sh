#!/bin/bash

set -e

echo "Installing Plymouth boot splash..."

sudo apt install -y plymouth plymouth-themes

# Create CalyxOS Plymouth theme directory
THEME_DIR="/usr/share/plymouth/themes/calyxos"
sudo mkdir -p "$THEME_DIR"

# Copy splash image from src/assets
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
sudo cp "$SCRIPT_DIR/../src/assets/huron-splash.jpg" "$THEME_DIR/splash.png"

# Create theme.properties
sudo tee "$THEME_DIR/theme.properties" > /dev/null << 'EOF'
[Plymouth Theme]
Name=CalyxOS
Description=CalyxOS Huron
Module=script

[script]
ImageDir=/usr/share/plymouth/themes/calyxos
ScriptFile=/usr/share/plymouth/themes/calyxos/calyxos.script
EOF

# make script to display static image
sudo tee "$THEME_DIR/calyxos.script" > /dev/null << 'EOF'
Window.SetBackgroundTopColor(0, 0, 0);
Window.SetBackgroundBottomColor(0, 0, 0);

splash_image = Image("splash.png");
sprite = Sprite(splash_image);
sprite.SetX((Window.GetWidth() - splash_image.GetWidth()) / 2);
sprite.SetY((Window.GetHeight() - splash_image.GetHeight()) / 2);
EOF

# set the theme
sudo plymouth-set-default-theme calyxos

# Update initramfs
sudo update-initramfs -u

echo "Plymouth installed with CalyxOS splash"
echo "  (Reboot to see boot splash)"
