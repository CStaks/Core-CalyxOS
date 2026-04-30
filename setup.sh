#!/bin/bash

set -e

echo "========================================"
echo "  CalyxOS Huron Setup"
echo "========================================"
echo ""

# asks for sudo password once so user doesnt need to continue inputting it
sudo -v

# Keep sudo alive during installation
while true; do sudo -n true; sleep 60; kill -0 $$ 2>/dev/null || exit; done &

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Run setup modules from src/
echo ""
echo "[1/5] Installing applications..."
bash "$SCRIPT_DIR/src/apps.sh"

echo ""
echo "[2/5] Installing themes..."
bash "$SCRIPT_DIR/src/themes.sh"

echo ""
echo "[3/5] Setting branding..."
bash "$SCRIPT_DIR/src/branding.sh"

echo ""
echo "[4/5] Configuring user defaults..."
bash "$SCRIPT_DIR/src/config.sh"

echo ""
echo "[5/5] Installing Plymouth boot splash..."
bash "$SCRIPT_DIR/src/plymouth.sh"

echo ""
echo "========================================"
echo "  CalyxOS Huron setup complete!"
echo "========================================"
echo "New users will inherit CalyxOS defaults."
echo ""
echo "Rebooting in 5 seconds... (Ctrl+C to cancel)"
sleep 5
sudo reboot
