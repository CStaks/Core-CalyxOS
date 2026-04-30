#!/bin/bash

set -e

echo "Configuring default user environment..."

# Create /etc/skel for structure stuff
sudo mkdir -p /etc/skel/.config

# configure KDE defaults for new users
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

# Apply to existing users if the user made one during debian setup (UID >= 1000)
echo "Applying configs to existing users..."
while IFS=: read -r username password uid gid gecos home shell; do
  if [ "$uid" -ge 1000 ] && [ -d "$home" ]; then
    sudo mkdir -p "$home/.config"
    sudo cp /etc/skel/.config/plasmarc "$home/.config/plasmarc"
    sudo chown "$uid:$gid" "$home/.config/plasmarc"
    echo "  ✓ Updated $username"
  fi
done < /etc/passwd

echo "User defaults configured"
