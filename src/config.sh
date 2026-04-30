#!/bin/bash

set -e

echo "Configuring default user environment..."

# Create /etc/skel for structure stuff
sudo mkdir -p /etc/skel/.config

# Configure KDE defaults for new users (plasmarc)
sudo tee /etc/skel/.config/plasmarc > /dev/null << 'EOF'
[General]
ColorScheme=MateriaDark
Theme=Materia-Dark

[Icons]
Theme=Papirus-Dark
EOF

# apply to existing users (UID >= 1000)
echo "Applying configs to existing users..."
while IFS=: read -r username password uid gid gecos home shell; do
  if [ "$uid" -ge 1000 ] && [ -d "$home" ]; then
    sudo mkdir -p "$home/.config"
    
    # Copy plasmarc
    sudo tee "$home/.config/plasmarc" > /dev/null << 'EOF'
[General]
ColorScheme=MateriaDark
Theme=Materia-Dark

[Icons]
Theme=Papirus-Dark
EOF
    
    # Set wallpaper (cuz lake huron is goated)
    sudo -u $username kwriteconfig5 --file "$home/.config/plasmarc" --group Wallpapers --key Image "file:///usr/share/backgrounds/calyxos/huron.jpg"
    
    sudo chown "$uid:$gid" "$home/.config/plasmarc"
    echo "✓ Updated $username"
  fi
done < /etc/passwd

echo "User defaults configured"
