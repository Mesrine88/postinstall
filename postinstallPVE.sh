#!/bin/bash

# PVE-Repo deaktivieren
mv  /etc/apt/sources.list.d/pve-enterprise.list  /etc/apt/sources.list.d/pve-enterprise.list.bak

# No-Subscription Repo
cat <<EOT > /etc/apt/sources.list
deb http://ftp.debian.org/debian bookworm main contrib non-free-firmware
deb http://ftp.debian.org/debian bookworm-updates  main contrib non-free-firmware
# Proxmox VE pve-no-subscription repository provided by proxmox.com,
# NOT recommended for production use
deb http://download.proxmox.com/debian/pve bookworm pve-no-subscription
# security updates
deb http://security.debian.org/debian-security bookworm-security main contrib non-free-firmware
EOT


## Install zfs-auto-snapshot
/usr/bin/env DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::='--force-confdef' install zfs-auto-snapshot
# make 5min snapshots , keep 12 5min snapshots
if [ -f "/etc/cron.d/zfs-auto-snapshot" ] ; then
  sed -i 's|--keep=[0-9]*|--keep=5|g' /etc/cron.d/zfs-auto-snapshot
  sed -i 's|*/[0-9]*|*/5|g' /etc/cron.d/zfs-auto-snapshot
fi
# keep 12 hourly snapshots
if [ -f "/etc/cron.hourly/zfs-auto-snapshot" ] ; then
  sed -i 's|--keep=[0-9]*|--keep=12|g' /etc/cron.hourly/zfs-auto-snapshot
fi
# keep 3 daily snapshots
if [ -f "/etc/cron.daily/zfs-auto-snapshot" ] ; then
  sed -i 's|--keep=[0-9]*|--keep=3|g' /etc/cron.daily/zfs-auto-snapshot
fi
# keep 1 weekly snapshots
if [ -f "/etc/cron.weekly/zfs-auto-snapshot" ] ; then
  sed -i 's|--keep=[0-9]*|--keep=1|g' /etc/cron.weekly/zfs-auto-snapshot
fi
# keep 1 monthly snapshots
if [ -f "/etc/cron.monthly/zfs-auto-snapshot" ] ; then
  sed -i 's|--keep=[0-9]*|--keep=1|g' /etc/cron.monthly/zfs-auto-snapshot
fi

# Tools installieren
apt update && apt upgrade -y && apt autoremove -y
apt install net-tools curl neofetch wget ntfs-3g ethtool sudo qemu-guest-agent nala git gnupg dos2unix -y

dos2unix *

# BashRC auf meine Wünsche anpassen
cat /apps/postinstall/.bashrc >> ~/.bashrc
source ~/.bashrc

# Profil durch aufgehübschtes MODT erweitern
cat /apps/postinstall/motd.sh >> /etc/profile.d/motd.sh
chmod +x /etc/profile.d/motd.sh

# Root-Anmeldung via SSH erlauben
chmod +x /apps/postinstall/allowRootSSHLogin.sh
bash /apps/postinstall/allowRootSSHLogin.sh

./installFastFetch.sh

# Remove Subscription Banner
sed -Ezi.bak "s/(Ext.Msg.show\(\{\s+title: gettext\('No valid sub)/void\(\{ \/\/\1/g" /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js && systemctl restart pveproxy.service

#Test
grep -n -B 1 'No valid sub' proxmoxlib.js

# For Restore
# Reinstall the proxmox-widget-toolkit package from the repository:
# apt-get install --reinstall proxmox-widget-toolkit

nala fetch
