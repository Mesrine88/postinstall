#!/bin/bash

# Tools installieren
apt update && apt upgrade -y
apt install net-tools curl neofetch wget qemu-guest-agent git nala gnupg dos2unix sudo -y

# Dateien in Unix konvertieren
dos2unix *

# BashRC auf meine Wünsche anpassen
cat /apps/postinstall/.bashrc >> ~/.bashrc

# angepasste Bash nutzen
source ~/.bashrc

# Profil durch aufgehübschtes MODT erweitern
cat /apps/postinstall/motd.sh >> /etc/profile.d/motd.sh
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


#############################################################################
# folgende 2-3 Abschnitte müssen erstmal getestet werden, bisher nur ein
# Schreibtisch-Test erfolg....
#############################################################################

# Inhalt des Skriptes editInterfacesDebVM.sh
cat <<EOT >> /apps/editInterfacesDebVM.sh
#!/bin/bash

# Funktion zum Prüfen, ob eine Zeile den Muster "iface <interface>" entspricht
is_iface_line() {
    [[ "$1" =~ ^[[:space:]]*iface[[:space:]]+$2[[:space:]]+inet ]]
}

# Funktion zum Bearbeiten der Datei basierend auf den Benutzerantworten
edit_interfaces_file() {
    local iface="$1"
    local ip="$2"
    local netmask="$3"
    local dns="$4"
    local gateway="$5"

    local temp_file=$(mktemp /tmp/interfaces.XXXXXX)

    # Durchsuche die Datei nach dem Muster "iface <interface>"
    while IFS= read -r line; do
        if is_iface_line "$line" "$iface"; then
            # Wenn das Muster gefunden wird, füge die statische Konfiguration hinzu
            echo "iface $iface inet static" >> "$temp_file"
            echo "    address $ip" >> "$temp_file"
            echo "    netmask $netmask" >> "$temp_file"
            echo "    dns-nameservers $dns" >> "$temp_file"
            echo "    gateway $gateway" >> "$temp_file"
        else
            # Andernfalls füge die Zeile unverändert hinzu
            echo "$line" >> "$temp_file"
        fi
    done < "/etc/network/interfaces"

    # Ersetze die alte Datei durch die neue
    mv "$temp_file" "/etc/network/interfaces"
}

# Hauptskript

read -p "Möchten Sie DHCP oder Static konfigurieren? (1=DHCP/2=Static): " config_type

if [ "$config_type" == "1" ]; then
    # Finde das Standard-Interface
    default_iface=$(ip route | awk '/default/ {print $5}')
    
    # Bearbeite die Datei für DHCP
    echo "iface $default_iface inet dhcp" > "/etc/network/interfaces"
    echo "DHCP-Konfiguration für $default_iface wurde angewendet."

elif [ "$config_type" == "2" ]; then
    # Frage nach den erforderlichen Informationen für die statische Konfiguration
    read -p "Geben Sie die IP-Adresse an: " ip
    read -p "Geben Sie die Netmask an (Drücken Sie Enter für 255.255.252.0): " netmask
    netmask=${netmask:-255.255.252.0}
    read -p "Geben Sie den DNS-Server an (Drücken Sie Enter für 10.0.17.12 9.9.9.9): " dns
    dns=${dns:-10.0.17.12 9.9.9.9}
    read -p "Geben Sie das Gateway an (Drücken Sie Enter für 10.0.17.1): " gateway
    gateway=${gateway:-10.0.17.1}

    # Bearbeite die Datei für die statische Konfiguration
    iface=$(ip route | awk '/default/ {print $5}')
    edit_interfaces_file "$iface" "$ip" "$netmask" "$dns" "$gateway"
    echo "Statische Konfiguration wurde angewendet."

else
    echo "Ungültige Auswahl. Das Skript wird beendet."
    exit 1
fi
systemctl restart networking.service
EOT

chmod +x /apps/editInterfacesDebVM.sh

# Hostname anpassen

cat <<EOT >> /apps/editHostname.sh
#!/bin/bash

# Aktuellen Hostnamen abrufen
current_hostname=$(hostname)

# Den aktuellen Hostnamen anzeigen
echo "Aktueller Hostname: $current_hostname"

# Benutzer nach der Änderung des Hostnamens fragen
read -p "Möchten Sie den Hostnamen ändern? (j/n): " change_hostname

if [ "$change_hostname" == "j" ]; then
    # Nach dem neuen Hostnamen fragen
    read -p "Geben Sie den neuen Hostnamen ein: " new_hostname

    # Den Hostnamen ändern
    hostnamectl set-hostname "$new_hostname"

    # Den Benutzer informieren
    echo "Hostname wurde zu $new_hostname geändert."

    # Ein Neustart kann erforderlich sein, damit die Änderungen wirksam werden
    read -p "Möchten Sie den Computer jetzt neu starten? (j/n): " restart
    if [ "$restart" == "j" ]; then
        reboot now
    else
        echo "Bitte vergessen Sie nicht, den Computer neu zu starten, damit die Änderungen wirksam werden."
    fi

else
    echo "Der Hostname bleibt unverändert."
fi
EOT

chmod +x /apps/editHostname.sh

chmod +x installFastFetch.sh
./installFastFetch.sh

nala fetch
