#!/bin/bash
# Dotfiles Installer for Artix Linux (OpenRC)
# Last updated: 29 June 2026

set -e

DOTFILES="$HOME/dotfiles"
SCRIPTS_DIR="$HOME/doc/kodingan/skrip"

echo "=== Dotfiles Installer ==="
echo "System: Artix Linux (OpenRC)"
echo ""

# 1. Stow packages
echo "[1/5] Installing stow packages..."
STOW_PACKAGES="bashrc i3 kitty picom i3status neofetch ranger htop btop cava gtk mimeapps"
for package in $STOW_PACKAGES; do
    if [ -d "$DOTFILES/$package" ]; then
        stow -d "$DOTFILES" -t "$HOME" "$package"
        echo "  ✓ $package"
    fi
done

# 2. Copy scripts
echo "[2/5] Copying scripts..."
mkdir -p "$SCRIPTS_DIR"
cp -r "$DOTFILES/scripts/"* "$SCRIPTS_DIR/" 2>/dev/null
chmod +x "$SCRIPTS_DIR"/*.sh 2>/dev/null
echo "  ✓ scripts copied to $SCRIPTS_DIR"

# 3. System configs (need root)
echo "[3/5] System configs (need sudo)..."
echo "  Run these commands manually:"
echo ""
echo "  # X11 configs"
echo "  sudo cp $DOTFILES/system/xorg/xorg.conf.d/* /etc/X11/xorg.conf.d/"
echo ""
echo "  # OpenRC init scripts"
echo "  sudo cp $DOTFILES/system/openrc/* /etc/init.d/"
echo "  sudo chmod +x /etc/init.d/nftables /etc/init.d/sshd"
echo ""
echo "  # conf.d files"
echo "  sudo cp $DOTFILES/system/conf.d/hostname /etc/conf.d/"
echo "  sudo cp $DOTFILES/system/conf.d/keymaps /etc/conf.d/"
echo "  sudo cp $DOTFILES/system/conf.d/consolefont /etc/conf.d/"
echo "  sudo cp $DOTFILES/system/conf.d/net /etc/conf.d/"
echo ""
echo "  # Hardware configs"
echo "  sudo cp $DOTFILES/system/modprobe.d/* /etc/modprobe.d/"
echo "  sudo cp $DOTFILES/system/modules-load.d/* /etc/modules-load.d/"
echo "  sudo cp $DOTFILES/system/udev/rules.d/* /etc/udev/rules.d/"
echo ""
echo "  # Security configs"
echo "  sudo cp $DOTFILES/system/nftables/nftables.conf /etc/nftables.conf"
echo "  sudo cp $DOTFILES/system/sysctl.d/* /etc/sysctl.d/"
echo "  sudo cp $DOTFILES/system/audit/rules.d/* /etc/audit/rules.d/"
echo "  sudo cp $DOTFILES/system/polkit/rules.d/* /etc/polkit-1/rules.d/"
echo "  sudo cp $DOTFILES/system/fail2ban/jail.local /etc/fail2ban/"
echo ""
echo "  # Pacman config"
echo "  sudo cp $DOTFILES/system/pacman/makepkg.conf /etc/"
echo ""

# 4. Reload services
echo "[4/5] Reload services (need sudo)..."
echo "  sudo sysctl --system"
echo "  sudo augenrules --load"
echo "  sudo rc-service nftables restart"
echo "  sudo rc-service fail2ban restart"
echo "  sudo rc-service apparmor restart"
echo ""

# 5. Enable services
echo "[5/5] Enable services (need sudo)..."
echo "  sudo rc-update add nftables default"
echo "  sudo rc-update add fail2ban default"
echo "  sudo rc-update add sshd default"
echo "  sudo rc-update add docker default"
echo ""

echo "=== Done! ==="
echo "Restart i3: Mod+Shift+r"
