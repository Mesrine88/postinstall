#!/bin/bash
cd /apps

# Download Fastfetch with Debian-AMD64
wget https://github.com/fastfetch-cli/fastfetch/releases/download/2.13.2/fastfetch-linux-amd64.deb


# On Other Systems

#    Ubuntu: ppa:zhangsongcui3371/fastfetch (for Ubuntu 22.04 or newer)
#    Arch Linux: sudo pacman -S fastfetch
#    Fedora: sudo dnf install fastfetch
#    Gentoo: sudo emerge --ask app-misc/fastfetch
#    Alpine: apk add --upgrade fastfetch
#    NixOS: nix-shell -p fastfetch
#    openSUSE: sudo zypper install fastfetch
#    ALT Linux: sudo apt-get install fastfetch

# Installation
apt install fastfetch-linux-amd64.deb

# Only my own VMs with /etc/profile.d/modt.sh
sudo sed -i 's/neofetch/fastfetch/' /etc/profile.d/motd.sh
# or sometimes
# sudo sed -i 's/neofetch/fastfetch/' /etc/profile.d/wwlabs.sh

# Remove abandoned neofetch
apt purge neofetch -y
