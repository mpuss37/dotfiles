# Security Setup

## Firewall (nftables)
- Policy: DROP all incoming
- Allowed ports: 22 (SSH), 80,443 (LAMPP), 3306 (MySQL)

## fail2ban
- SSH jail: max 3 retries, 1 hour ban
- Apache auth: max 5 retries, 1 hour ban
- Apache overflows: max 2 retries, 2 hour ban
- Apache botsearch: max 2 retries, 24 hour ban

## AppArmor
- Firefox: enforced
- Kitty: enforced (with GPU, home, network access)

## Audit Rules
- Monitor: /etc/passwd, /etc/shadow, /etc/sudoers
- Monitor: /etc/ssh/sshd_config
- Monitor: kernel modules (insmod, rmmod, modprobe)
- Monitor: cron jobs
- Monitor: login/logout events

## Sysctl Hardening
- net.ipv4.tcp_syncookies = 1
- net.ipv4.conf.all.rp_filter = 1
- net.ipv4.icmp_echo_ignore_all = 1
- net.ipv4.conf.all.log_martians = 1
- vm.swappiness = 15

## Polkit Rules
- Users can manage NetworkManager without password
- Users can manage Bluetooth without password
- Users can manage power settings without password

## Service Users
- mysql: /usr/bin/nologin
- postgres: /usr/bin/nologin
