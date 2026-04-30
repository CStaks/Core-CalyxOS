#!/bin/bash

set -e

echo "========================================"
echo "  CalyxOS Huron Setup"
echo "========================================"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Run setup modules - split for organization
echo ""
echo "[1/5] Installing applications..."
sudo bash "$SCRIPT_DIR/src/apps.sh"

echo ""
echo "[2/5] Installing themes..."
sudo bash "$SCRIPT_DIR/src/themes.sh"

echo ""
echo "[3/5] Setting branding..."
sudo bash "$SCRIPT_DIR/src/branding.sh"

echo ""
echo "[4/5] Configuring user defaults..."
sudo bash "$SCRIPT_DIR/src/config.sh"

echo ""
echo "[5/5] Installing Plymouth boot splash..."
sudo bash "$SCRIPT_DIR/src/plymouth.sh"

echo ""
echo "========================================"
echo "  CalyxOS Huron setup complete!"
echo "========================================"
echo ""
echo "--------------------------------------"
echo "Rebooting your system is reccomended"
echo "--------------------------------------"
