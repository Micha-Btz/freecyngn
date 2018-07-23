## iptables.sh
## AFWall+ additional firewall rules

IPTABLES=/system/bin/iptables
IP6TABLES=/system/bin/ip6tables

# All 'afwall' chains/rules gets flushed automatically, before the custom script is executed

# Flush/Purge all rules expect OUTPUT (quits with error)
$IPTABLES -F INPUT
$IPTABLES -F FORWARD
$IPTABLES -t nat -F
$IPTABLES -t mangle -F
$IP6TABLES -F INPUT
$IP6TABLES -F FORWARD
$IP6TABLES -t nat -F
$IP6TABLES -t mangle -F

# Flush/Purge all chains
$IPTABLES -X
$IPTABLES -t nat -X
$IPTABLES -t mangle -X
$IP6TABLES -X
$IP6TABLES -t nat -X
$IP6TABLES -t mangle -X

# Deny IPv6 connections
$IP6TABLES -P INPUT DROP
$IP6TABLES -P FORWARD DROP
$IP6TABLES -P OUTPUT DROP

# DNS Server Chaos Computer Club except for wifi home use dnsmasq from freetz
$IPTABLES -t nat -I OUTPUT ! -s 192.168.2.0/24 -p tcp --dport 53 -j DNAT --to-destination 91.239.100.100:53
$IPTABLES -t nat -I OUTPUT ! -s 192.168.2.0/24 -p udp --dport 53 -j DNAT --to-destination 91.239.100.100:53

# Force a specific NTP (ntp0.fau.de), Location: University Erlangen-Nuernberg
$IPTABLES -t nat -A OUTPUT -p tcp --dport 123 -j DNAT --to-destination 131.188.3.222:123
$IPTABLES -t nat -A OUTPUT -p udp --dport 123 -j DNAT --to-destination 131.188.3.222:123
# Allow SSH from desktop
$IPTABLES -A INPUT -p tcp --dport 22 -s 192.168.2.105 -j ACCEPT
#dietpi
$IPTABLES -A OUTPUT -d 192.168.2.107 -j ACCEPT
