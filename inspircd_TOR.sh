#!/bin/bash

# Scegli la distribuzione
echo "Scegli la tua distribuzione:"
echo "1) Ubuntu/Debian"
echo "2) Arch Linux"
echo "3) Fedora"
read -p "Inserisci il numero corrispondente alla tua distribuzione: " DISTRO

# Installa inspircd e tor
if [ "$DISTRO" == "1" ]; then
    sudo apt install -y inspircd tor
elif [ "$DISTRO" == "2" ]; then
    sudo pacman -S inspircd tor
elif [ "$DISTRO" == "3" ]; then
    sudo dnf install -y inspircd tor
else
    echo "Distribuzione non supportata."
    exit 1
fi

# Cambia l'intestazione in /etc/inspircd/inspircd.motd
echo "-------------------------------------
Welcome to super secret chat
-------------------------------------" | sudo tee /etc/inspircd/inspircd.motd

# Avvia il servizio inspircd
sudo service inspircd start

# Controlla lo stato del servizio inspircd
sudo service inspircd status

# Cambia la configurazione in /etc/inspircd/inspircd.conf
# (Assumendo che il tuo indirizzo IP della macchina sia 192.168.1.100)
echo "bind
{
   address = \"192.168.1.100\";
   port = \"6667\";
}" | sudo tee /etc/inspircd/inspircd.conf

# Crea un servizio nascosto con TOR
# Cambia il file torrc (/etc/tor/torrc) con la configurazione seguente
echo "HiddenServiceDir /var/lib/tor/hidden_service/
HiddenServicePort 6667 127.0.0.1:6667" | sudo tee /etc/tor/torrc

# Avvia tor in background e ottieni il dominio onion
sudo tor &
echo "Il tuo dominio onion è:"
sudo cat /var/lib/tor/hidden_service/hostname
