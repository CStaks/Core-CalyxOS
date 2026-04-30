#!/bin/bash

set -e

echo "Configuring default user environment..."

# create /etc/skel for structure stuff
sudo mkdir -p /etc/skel/.config

# Configure KDE defaults for new users
sudo tee /etc/skel/.config/plasmarc > /dev/null << 'EOF'
[General]
ColorScheme=MateriaDark
Theme=Materia-Dark

[Icons]
Theme=Papirus-Dark
EOF

# Apply to existing users (UID >= 1000)
echo "Applying configs to existing users..."
while IFS=: read -r username password uid gid gecos home shell; do
  if [ "$uid" -ge 1000 ] && [ -d "$home" ]; then
    sudo mkdir -p "$home/.config"
    
    # Copy plasmarc
    sudo cp /etc/skel/.config/plasmarc "$home/.config/plasmarc"
    sudo chown "$uid:$gid" "$home/.config/plasmarc"
    
    # Set wallpaper directly
    sudo -u $username plasma-apply-wallpaperimage /usr/share/backgrounds/calyxos/huron.jpg
    
    echo "Updated $username"
  fi
done < /etc/passwd

echo "User defaults configured"
