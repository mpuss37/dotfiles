# Changelog

## 29 June 2026
- Restructured dotfiles with stow
- Added system configs (nftables, fail2ban, apparmor, audit)
- Added scripts documentation
- Added OpenRC init scripts (sshd, nftables)
- Fixed kernel mismatch (7.0.12 → 7.0.13)
- Configured fail2ban with Apache jails
- Added AppArmor profiles for Firefox and Kitty
- Added polkit rules for users
- Added audit rules for security monitoring

## Initial Setup
- Installed from Artix minimal base ISO
- Configured OpenRC init system
- Set up i3wm with custom keybindings
- Installed development tools
- Configured network with NetworkManager
