# dotfiles

Kumpulan konfigurasi pribadi (dotfiles) untuk **Artix Linux OpenRC + i3wm**,
dipakai dengan [GNU Stow](https://www.gnu.org/software/stow/).

> Snapshot konfigurasi yang benar-benar dipakai di sistem aktif.
> Untuk installer otomasi lengkap (paket, service, config `/etc`, security),
> lihat repo terpisah: [`artix-openrc-installer`](https://github.com/mpuss37/artix-openrc-installer).

## Isi

| Package | Target | Keterangan |
|---------|--------|------------|
| `bashrc`      | `~/.bashrc`                       | Shell config, alias, export, fungsi |
| `i3`          | `~/.config/i3/config`             | Window manager i3 |
| `i3status`    | `~/.config/i3status/`             | Status bar i3 |
| `kitty`       | `~/.config/kitty/kitty.conf`      | Terminal (JetBrains Mono) |
| `picom`       | `~/.config/picom/picom.conf`      | Compositor |
| `neofetch`    | `~/.config/neofetch/config.conf`  | Info sistem |
| `ranger`      | `~/.config/ranger/`               | File manager |
| `htop`        | `~/.config/htop/htoprc`           | Process viewer |
| `btop`        | `~/.config/btop/btop.conf`        | Resource monitor |
| `cava`        | `~/.config/cava/config`           | Audio visualizer |
| `mimeapps`    | `~/.config/mimeapps.list`         | Asosiasi aplikasi default |
| `scripts`     | `~/doc/kodingan/skrip/`           | Skrip utilitas (audio, brightness, screenshot, wifi, system) |

## Cara Pakai

Butuh `stow`:

```bash
sudo pacman -S stow
```

Stow semua dotfiles ke `$HOME`:

```bash
git clone https://github.com/mpuss37/dotfiles.git ~/dotfiles
cd ~/dotfiles
stow -t "$HOME" bashrc i3 i3status kitty picom neofetch ranger htop btop cava mimeapps
```

Atau satu per satu:

```bash
stow -t "$HOME" i3
```

### Unstow

```bash
stow -D -t "$HOME" i3
```

## Catatan

- `scripts/` tidak di-stow ke `$HOME` langsung; installer menyalinnya ke
  `~/doc/kodingan/skrip/`. Kalau pakai repo ini sendiri, stow/salin manual.
- File yang memuat kredensial (API key, SSID/password WiFi) sudah
  di-sanitasi menjadi placeholder.
