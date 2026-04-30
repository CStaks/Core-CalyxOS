#!/bin/bash

set -e

echo "Configuring default user environment..."

# Create /etc/skel structure
sudo mkdir -p /etc/skel/.config

# Configure KDE defaults for new users
sudo tee /etc/skel/.config/plasmarc > /dev/null << 'EOF'
[General]
ColorScheme=MateriaDark
Theme=Materia-Dark

[Icons]
Theme=Papirus-Dark

[Wallpapers]
plasmadesktop=Image
Image=file:///usr/share/backgrounds/calyxos/huron.jpg
EOF

echo "User defaults configured"
