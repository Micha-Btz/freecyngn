##
## iptables_off.sh
## AFWall+ shutdown actions
## Mike Kuketz
## www.kuketz-blog.de
##

IPTABLES=/system/bin/iptables
IP6TABLES=/system/bin/ip6tables

# Flush/Purge all rules
$IPTABLES -F
$IPTABLES -t nat -F
$IPTABLES -t mangle -F
$IP6TABLES -F
$IP6TABLES -t nat -F
$IP6TABLES -t mangle -F

# Flush/Purge all chains
$IPTABLES -X 
$IPTABLES -t nat -X
$IPTABLES -t mangle -X
$IP6TABLES -X 
$IP6TABLES -t nat -X
$IP6TABLES -t mangle -X

# Allow IPv4 connections 
$IPTABLES -P INPUT ACCEPT
$IPTABLES -P FORWARD ACCEPT
$IPTABLES -P OUTPUT ACCEPT

# Deny IPv6 connections 
$IP6TABLES -P INPUT DROP 
$IP6TABLES -P FORWARD DROP
$IP6TABLES -P OUTPUT DROP 
