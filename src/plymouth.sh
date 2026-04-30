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

# Create calyxos.plymouth (main theme file)
sudo tee "$THEME_DIR/calyxos.plymouth" > /dev/null << 'EOF'
[Plymouth Theme]
Name=CalyxOS
Description=CalyxOS Huron splash screen
ModuleName=script

[script]
ImageDir=/usr/share/plymouth/themes/calyxos
ScriptFile=/usr/share/plymouth/themes/calyxos/calyxos.script
EOF

# make calyxos.script (loads & centers image)
sudo tee "$THEME_DIR/calyxos.script" > /dev/null << 'EOF'
image = Image("splash.png");

pos_x = Window.GetWidth()/2 - image.GetWidth()/2;
pos_y = Window.GetHeight()/2 - image.GetHeight()/2;

sprite = Sprite(image);
sprite.SetX(pos_x);
sprite.SetY(pos_y);

fun refresh_callback () {
  sprite.SetOpacity(1);
}

Plymouth.SetRefreshFunction(refresh_callback);
EOF

# set the theme
sudo plymouth-set-default-theme calyxos

# Update initramfs
sudo update-initramfs -u

echo "✓ Plymouth installed with CalyxOS splash"
echo "  (Reboot to see boot splash)"
