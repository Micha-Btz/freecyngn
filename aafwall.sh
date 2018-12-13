## iptables.sh
## AFWall+ additional firewall rules
## source https://www.kuketz-blog.de/afwall-unter-android-oreo-custom-script-vorlage/
####################
# Tweaks #
####################
## Kernel
# Disable IPv6
echo 0 > /proc/sys/net/ipv6/conf/wlan0/accept_ra
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
echo 1 > /proc/sys/net/ipv6/conf/default/disable_ipv6
# Privacy IPv6 Address
echo 2 > /proc/sys/net/ipv6/conf/all/use_tempaddr
echo 2 > /proc/sys/net/ipv6/conf/default/use_tempaddr

## System
# Disable Global NTP Server
settings put global ntp_server 127.0.0.1

####################
# iptables #
####################
IPTABLES=/system/bin/iptables
IP6TABLES=/system/bin/ip6tables

####################
# Defaults #
####################
# IPv4 connections
$IPTABLES -P INPUT DROP
$IPTABLES -P FORWARD DROP
$IPTABLES -P OUTPUT DROP

# IPv6 connections
$IP6TABLES -P INPUT DROP
$IP6TABLES -P FORWARD DROP
$IP6TABLES -P OUTPUT DROP

#####################
# Special Rules #
#####################
# Allow loopback interface lo
$IPTABLES -A INPUT -i lo -j ACCEPT
$IPTABLES -A "afwall" -o lo -j ACCEPT

# Set a specific DNS-Server (dismail.de AdBlocking DNS-Server) for all networks except home WiFi (192.168.2.0/24)
$IPTABLES -t nat -I OUTPUT ! -s 192.168.2.0/24 -p tcp --dport 53 -j DNAT --to-destination 80.241.218.68:53
$IPTABLES -t nat -I OUTPUT ! -s 192.168.2.0/24 -p udp --dport 53 -j DNAT --to-destination 80.241.218.68:53

# Force a specific NTP (ntp0.fau.de), Location: University Erlangen-Nuernberg
$IPTABLES -t nat -A OUTPUT -p tcp --dport 123 -j DNAT --to-destination 131.188.3.222:123
$IPTABLES -t nat -A OUTPUT -p udp --dport 123 -j DNAT --to-destination 131.188.3.222:123

#####################
# Incoming Traffic #
#####################
# Allow all traffic from an established connection
$IPTABLES -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Alle Pakete ordentlich zurückweisen
$IPTABLES -A INPUT -p tcp -j REJECT --reject-with tcp-reset
$IPTABLES -A INPUT -j REJECT --reject-with icmp-port-unreachable

#####################
# home rules        #
#####################
# Allow SSH from desktop
$IPTABLES -A INPUT -p tcp --dport 22 -s 192.168.2.105 -j ACCEPT
#dietpi
$IPTABLES -A OUTPUT -d 192.168.2.107 -j ACCEPT
#yeelight multi cast address
#$IPTABLES -A OUTPUT -d 192.168.2.150 -j ACCEPT
$IPTABLES -A OUTPUT -d  239.255.255.250:1982  -j ACCEPT
