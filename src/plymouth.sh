#!/bin/bash

set -e

echo "Installing Plymouth boot splash..."

sudo apt install -y plymouth plymouth-themes

# create CalyxOS Plymouth theme directory
THEME_DIR="/usr/share/plymouth/themes/calyxos"
sudo mkdir -p "$THEME_DIR"

# copy splash image from src/assets
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
sudo cp "$SCRIPT_DIR/../src/assets/huron-splash.jpg" "$THEME_DIR/splash.png"

# Create calyxos.plymouth
sudo tee "$THEME_DIR/calyxos.plymouth" > /dev/null << 'EOF'
[Plymouth Theme]
Name=CalyxOS
Description=CalyxOS Huron
Module=script

[script]
ImageDir=/usr/share/plymouth/themes/calyxos
ScriptFile=/usr/share/plymouth/themes/calyxos/calyxos.script
EOF

# Create calyxos.script to display static image
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
