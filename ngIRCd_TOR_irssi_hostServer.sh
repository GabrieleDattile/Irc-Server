#!/bin/bash

# Funzione per leggere l'input dell'utente
read_input() {
    echo "$1"
    read input
    echo $input
}

# Chiedi all'utente la distribuzione Linux
distro=$(read_input "Inserisci il numero corrispondente alla tua distribuzione Linux:\n1. Ubuntu/Debian\n2. Fedora\n3. Arch Linux")

# Imposta il comando di installazione in base alla distribuzione
case $distro in
  1) install_cmd="sudo apt-get install" ;;
  2) install_cmd="sudo dnf install" ;;
  3) install_cmd="sudo pacman -S" ;;
  *) echo "Distribuzione non supportata."; exit 1 ;;
esac

# Chiedi all'utente il nome del server e la password
server_name=$(read_input "Inserisci il nome del tuo server IRC:")
server_password=$(read_input "Inserisci la password del tuo server IRC:")

# Installa e configura Tor
$install_cmd tor
sudo sh -c 'cat > /etc/tor/torrc <<EOF
HiddenServiceDir /var/lib/tor/hidden_service/
HiddenServicePort 6667 127.0.0.1:6667
EOF'
sudo service tor start
echo "L'indirizzo Onion del tuo servizio è:"
sudo cat /var/lib/tor/hidden_service/hostname

# Installa e configura ngIRCd
$install_cmd ngircd
sudo sh -c 'cat > /etc/ngircd/ngircd.conf <<EOF
[Global]
    Name = $server_name
    Info = Your Server Info
    Motd = /etc/ngircd/ngircd.motd

[Options]
    PidFile = /var/run/ngircd/ngircd.pid
    Listen = 127.0.0.1

[Channel]
    Name = #YourChannel
    Topic = Your Topic
EOF'
sudo service ngircd start

# Installa e configura Irssi
$install_cmd irssi
echo "servers = ( { address = \"localhost\"; chatnet = \"Tor\"; port = \"6667\"; } );" > ~/.irssi/config
