import socket

# Connettiti con SSL
server = "irc.anonops.com"
channel = "#yourchannel"
botnick = "yourbotname"
port = 6697

irc = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
print("connecting to:"+server)
irc.connect((server, port))
irc.send(bytes("USER "+ botnick +" "+ botnick +" "+ botnick +" :This is a fun bot!\n", "UTF-8"))
irc.send(bytes("NICK "+ botnick +"\n", "UTF-8"))
irc.send(bytes("JOIN "+ channel +"\n", "UTF-8"))

# Connettiti con IPv6
# Cambia il nome del server in ipv6.anonops.com
server_ipv6 = "ipv6.anonops.com"
irc_ipv6 = socket.socket(socket.AF_INET6, socket.SOCK_STREAM)
print("connecting to:"+server_ipv6)
irc_ipv6.connect((server_ipv6, port))
irc_ipv6.send(bytes("USER "+ botnick +" "+ botnick +" "+ botnick +" :This is a fun bot!\n", "UTF-8"))
irc_ipv6.send(bytes("NICK "+ botnick +"\n", "UTF-8"))
irc_ipv6.send(bytes("JOIN "+ channel +"\n", "UTF-8"))

# Connettiti usando Hexchat su TOR
# Devi avere un nick registrato che è attivo da 3 giorni sulla nostra rete
# Cambia il nome del server in anonops4att3rwh3tsh2fhb3suwq6g575r6k36fsrc2ijkj75vcxhyd.onion
server_tor = "anonops4att3rwh3tsh2fhb3suwq6g575r36fsrc2ijkj75vcxhyd.onion"
irc_tor = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
print("connecting to:"+server_tor)
irc_tor.connect((server_tor, 443)) # Usa la porta 443 per TOR
irc_tor.send(bytes("USER "+ botnick +" "+ botnick +" "+ botnick +" :This is a fun bot!\n", "UTF-8"))
irc_tor.send(bytes("NICK "+ botnick +"\n", "UTF-8"))
irc_tor.send(bytes("JOIN "+ channel +"\n", "UTF-8"))

while 1:
    text=irc.recv(2040).decode("UTF-8")
    print(text)

    if text.find('PING') != -1:
        irc.send(bytes('PONG ' + text.split()[1] + '\r\n', "UTF-8"))
