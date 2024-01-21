#!/bin/bash

# Tools installieren
apt update && apt upgrade -y
apt install net-tools curl neofetch wget qemu-guest-agent git nala gnupg dos2unix sudo -y

# Dateien in Unix konvertieren
dos2unix *

# BashRC auf meine Wünsche anpassen
cp /apps/postinstall/.bashrc ~/.bashrc

# angepasste Bash nutzen
source ~/.bashrc

# Profil durch aufgehübschtes MODT erweitern
cp /apps/postinstall/motd.sh /etc/profile.d/motd.sh
# cp /apps/postinstall/baru-motd.sh >> /etc/profile.d/baru-motd.sh
# chmod +x /etc/profile.d/baru-motd.sh
chmod +x /etc/profile.d/motd.sh

# Benutzer nach Docker-Installation fragen
read -p "Möchten Sie Docker installieren? (y/n): " installDocker

# Überprüfen, ob die Antwort "ja" ist
if [ "$installDocker" == "y" ]; then
    # Wenn "ja", dann rufe das Installations-Skript auf
    ./installDocker.sh

    # Stardard Ordner für Volumes anlegen
    mkdir -p /volume1/docker/
    
    echo "Docker wurde installiert."
else
    # Wenn "nein", dann einfach weitergehen
    echo "Docker wird nicht installiert."
fi

# Benutzer fragen ob Root-Logins mit Passwort via SSH erlaubt werden sollen
read -p "Möchten Sie root erlauben sich mit dem Passwort via SSH zu verbinden? (y/n): " allowRootSSH

# Überprüfen, ob die Antwort "ja" ist
if [ "$allowRootSSH" == "y" ]; then
    # Wenn "ja", dann rufe das Installations-Skript auf
    ./allowRootSSHLogin.sh
    
    echo "User root kann sich nun mit seinem Passwort via SSH verbinden!"
else
    # Wenn "nein", dann einfach weitergehen
    echo "Root Zugriff via SSH ist nicht erlaubt."
fi


nala fetch
