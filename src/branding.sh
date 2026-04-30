#!/bin/bash

set -e

echo "Setting CalyxOS branding..."

# Create CalyxOS branding file
sudo tee /etc/calyx-release > /dev/null << 'EOF'
CalyxOS 1.0 (Huron)
EOF

# Download and set wallpaper system-wide
sudo mkdir -p /usr/share/backgrounds/calyxos
sudo wget -O /usr/share/backgrounds/calyxos/huron.jpg "https://github.com/CStaks/Core-CalyxOS/raw/main/src/assets/huron.jpg"

echo "✓ Branding set"
