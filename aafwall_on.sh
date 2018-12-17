## AFWall+ additional firewall rules
## Mike Kuketz
## www.kuketz-blog.de


IPTABLES=/system/bin/iptables
IP6TABLES=/system/bin/ip6tables

# Default deny connections

$IPTABLES -P INPUT DROP  
$IPTABLES -P FORWARD DROP  
$IPTABLES -P OUTPUT DROP

$IP6TABLES -P INPUT DROP  
$IP6TABLES -P FORWARD DROP  
$IP6TABLES -P OUTPUT DROP

####################
# Tweaks           #
####################
## Kernel
# Disable IPv6
echo 0 > /proc/sys/net/ipv6/conf/wlan0/accept_ra
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
echo 1 > /proc/sys/net/ipv6/conf/default/disable_ipv6
# Privacy IPv6 Address
echo 2 > /proc/sys/net/ipv6/conf/all/use_tempaddr
echo 2 > /proc/sys/net/ipv6/conf/default/use_tempaddr

# Allow loopback interface lo 
$IPTABLES -A INPUT -i lo -j ACCEPT
$IPTABLES -A "afwall" -o lo -j ACCEPT

##################### # Incoming Traffic # ##################### 

# Allow ICMP packets
$IPTABLES -A INPUT -p icmp -m icmp --icmp-type echo-reply -j ACCEPT
$IPTABLES -A INPUT -p icmp -m icmp --icmp-type echo-request -j ACCEPT
$IPTABLES -A INPUT -p icmp -m icmp --icmp-type destination-unreachable -j ACCEPT

# Allow all traffic from an established #connection 
$IPTABLES -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Alle Pakete ordentlich zurückweisen
$IPTABLES -A INPUT -p tcp -j REJECT --reject-with tcp-reset
$IPTABLES -A INPUT -j REJECT --reject-with icmp-port-unreachable


#Disable captive portal check
pm disable com.android.captiveportallogin 
settings put global captive_portal_detection_enabled 0
settings put global captive_portal_server localhost
settings put global captive_portal_mode 0

