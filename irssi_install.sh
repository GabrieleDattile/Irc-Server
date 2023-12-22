#!/bin/bash

echo "Scegli la tua distribuzione:"
echo "1) Ubuntu"
echo "2) Debian"
echo "3) Fedora"
echo "4) Arch Linux"
read -p "Inserisci il numero corrispondente alla tua distribuzione: " distro

case $distro in
  1)
    echo "Hai scelto Ubuntu"
    sudo apt update
    sudo apt install irssi
    ;;
  2)
    echo "Hai scelto Debian"
    sudo apt-get update
    sudo apt-get install irssi
    ;;
  3)
    echo "Hai scelto Fedora"
    sudo dnf update
    sudo dnf install irssi
    ;;
  4)
    echo "Hai scelto Arch Linux"
    sudo pacman -Syu
    sudo pacman -S irssi
    ;;
  *)
    echo "Distribuzione non supportata"
    exit 1
    ;;
esac

# Configurazione di base di irssi
mkdir -p ~/.irssi
cat << EOF > ~/.irssi/config
servers = (
  {
    address = "irc.freenode.net";
    chatnet = "Freenode";
    port = "6667";
    use_ssl = "no";
    ssl_verify = "no";
    autoconnect = "yes";
  }
);

channels = (
  {
    name = "#yourchannel";
    chatnet = "Freenode";
    autojoin = "yes";
  }
);
EOF

echo "Irssi è stato installato e configurato."
