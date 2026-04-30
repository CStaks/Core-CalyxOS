#!/bin/bash
set -e
echo "Installing KDE Plasma, Brave, Kitty and removing unecessary apps..."
# Update repos
sudo apt update && sudo apt upgrade -y
# Remove any stinky DE/WM (especially GNOME since its selected by default)
echo "Removing existing desktop environments..."
sudo apt remove -y \
  gnome-desktop-environment gnome-shell \
  xfce4 xfce4-session \
  lxde lxde-core \
  cinnamon \
  budgie-desktop \
  openbox i3 i3-wm \
  awesome dwm \
  2>/dev/null || true
sudo apt autoremove -y
# Install KDE Plasma
echo "Installing KDE Plasma..."
sudo apt install -y kde-plasma-desktop
# Add Brave repo (+100000 aura)
echo "Adding Brave repository..."
curl -fsSL https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo gpg --dearmor -o /usr/share/keyrings/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
# Install Brave, Kitty, and other applications that are goated
sudo apt install -y \
  brave-browser \
  kitty \
  vlc \
  gwenview \
  btop \
  libreoffice
# Set defaults
sudo update-alternatives --install /usr/bin/x-www-browser x-www-browser /usr/bin/brave-browser 100
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/bin/kitty 100
echo "Apps installed"
