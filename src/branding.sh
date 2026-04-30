#!/bin/bash

set -e

echo "Setting CalyxOS branding..."

# Create CalyxOS branding file
sudo tee /etc/calyx-release > /dev/null << 'EOF'
CalyxOS 1.0 (Huron)
EOF

# wallpaper setup (aura)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
sudo mkdir -p /usr/share/backgrounds/calyxos
sudo cp "$SCRIPT_DIR/../src/assets/huron.jpg" /usr/share/backgrounds/calyxos/huron.jpg

echo "Branding set"
