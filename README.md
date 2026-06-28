# dotfiles - Artix Linux Setup

> **System**: Artix Linux (OpenRC) | Kernel 7.0.13 | i3wm
> **Last Updated**: 29 June 2026
> **Hardware**: Intel i3-1005G1, 11GB RAM, NVMe SSD
> **Init**: OpenRC (systemd-free)

## Quick Start

```bash
git clone https://github.com/mpuss37/dotfiles.git
cd dotfiles
./install.sh
```

## Structure

| Folder | Description |
|--------|-------------|
| `bashrc/` | Shell config (.bashrc) |
| `i3/` | i3 window manager config |
| `kitty/` | Kitty terminal config |
| `picom/` | Picom compositor config |
| `i3status/` | i3status bar config |
| `neofetch/` | Neofetch system info |
| `ranger/` | Ranger file manager |
| `htop/` | Htop process viewer |
| `btop/` | Btop process viewer |
| `cava/` | Cava audio visualizer |
| `gtk/` | GTK theme settings |
| `mimeapps/` | File associations |
| `scripts/` | Automation scripts |
| `system/` | System configs (need root) |
| `docs/` | Documentation |

## Key Packages

i3-wm, kitty, picom, i3status, firefox, ranger, fzf, ripgrep, btop, htop,
cava, neofetch, nftables, fail2ban, apparmor, audit, stow

## Security

- nftables firewall (LAMPP ports open)
- fail2ban (SSH + Apache jails)
- AppArmor (Firefox + Kitty enforced)
- Audit rules (passwd, shadow, sudoers, sshd)
- Sysctl hardening (SYN cookies, IP spoofing, etc)

## Scripts Guide

See [docs/scripts.md](docs/scripts.md)

## System Configs

See [docs/system-info.md](docs/system-info.md)
