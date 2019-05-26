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

#####################
# Incoming Traffic #
#####################
# Allow all traffic from an established connection
$IPTABLES -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
# Set a specific DNS-Server (dismail.de AdBlocking DNS-Server) for all networks except home WiFi (192.168.2.0/24)
$IPTABLES -t nat -I OUTPUT ! -s 192.168.2.0/24 -p tcp --dport 53 -j DNAT --to-destination 80.241.218.68:53
$IPTABLES -t nat -I OUTPUT ! -s 192.168.2.0/24 -p udp --dport 53 -j DNAT --to-destination 80.241.218.68:53

# Force a specific NTP (ntp0.fau.de), Location: University Erlangen-Nuernberg
$IPTABLES -t nat -A OUTPUT -p tcp --dport 123 -j DNAT --to-destination 131.188.3.222:123
$IPTABLES -t nat -A OUTPUT -p udp --dport 123 -j DNAT --to-destination 131.188.3.222:123

#####################
# home rules        #
#####################
export SYSIPHUS=192.168.2.105
export SCHNUDDEL=192.168.2.106
export DIETPI=192.168.2.107
export BQ=192.168.2.108
export Z1C=192.168.2.109
export CEILING=192.168.2.150

$IPTABLES -A OUTPUT -s ${BQ} -d ${DIETPI} -j ACCEPT
$IPTABLES -A OUTPUT -s ${BQ} -d ${SYSIPHUS} -j ACCEPT
$IPTABLES -A OUTPUT -s ${Z1C} -d ${SYSIPHUS} -j ACCEPT
$IPTABLES -A OUTPUT -s ${Z1C} -d ${DIETPI} -j ACCEPT
$IPTABLES -A OUTPUT -s ${BQ} -d ${CEILING} -j ACCEPT
$IPTABLES -A OUTPUT -s ${Z1C} -d ${CEILING} -j ACCEPT
$IPTABLES -A OUTPUT -s ${BQ} -d ${SCHNUDDEL} -j ACCEPT
$IPTABLES -A OUTPUT -s ${Z1C} -d ${SCHNUDDEL} -j ACCEPT
$IPTABLES -A INPUT -s ${SYSIPHUS} -d ${BQ} -j ACCEPT
$IPTABLES -A INPUT -s ${SYSIPHUS} -d ${Z1C} -j ACCEPT
$IPTABLES -A INPUT -s ${DIETPI} -d ${Z1C} -j ACCEPT
$IPTABLES -A INPUT -s ${DIETPI} -d ${BQ} -j ACCEPT
$IPTABLES -A INPUT -s ${CEILING} -d ${BQ} -j ACCEPT
$IPTABLES -A INPUT -s ${CEILING} -d ${Z1C} -j ACCEPT
$IPTABLES -A INPUT -s ${SCHNUDDEL} -d ${BQ} -j ACCEPT
$IPTABLES -A INPUT -s ${SCHNUDDEL} -d ${Z1C} -j ACCEPT


#yeelight multi cast address
#export CHROMECAST_IP=192.168.2.150 # Adjust to the Chromecast IP in your local network
#$IPTABLES -A INPUT -s ${CEILING} -p udp -m multiport --sports 32768:61000 -m multiport --dports 32768:61000 -m comment --comment "Allow Chromecast UDP data (inbound)" -j ACCEPT
#$IPTABLES -A OUTPUT -d ${CEILING} -p udp -m multiport --sports 32768:61000 -m multiport --dports 32768:61000 -m comment --comment "Allow Chromecast UDP data (outbound)" -j ACCEPT
#$IPTABLES -A OUTPUT -d ${CEILING} -p tcp -m multiport --dports 8008:8009 -m comment --comment "Allow Chromecast TCP data (outbound)" -j ACCEPT
#$IPTABLES -A OUTPUT -d 239.255.255.250/32 -p udp --dport 1982 -m comment --comment "Allow Chromecast SSDP" -j ACCEPT
#$IPTABLES -A INPUT -d 239.255.255.250/32 -p udp --dport 1982 -m comment --comment "Allow Chromecast SSDP" -j ACCEPT
#$IPTABLES -I INPUT -p udp -m udp --dport 32768:61000 -j ACCEPT

$IPTABLES -A OUTPUT -d 192.168.2.0/24 -j ACCEPT
$IPTABLES -A OUTPUT -d 239.255.255.250/32 -p udp --dport 1982 -j ACCEPT

# Alle Pakete ordentlich zurückweisen
#$IPTABLES -A INPUT -p tcp -j REJECT --reject-with tcp-reset
#$IPTABLES -A INPUT -j REJECT --reject-with icmp-port-unreachable
