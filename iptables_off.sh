##
## iptables_off.sh
## AFWall+ shutdown actions
## Mike Kuketz
## www.kuketz-blog.de
##

IPTABLES=/system/bin/iptables
IP6TABLES=/system/bin/ip6tables

# Allow IPv4 connections 
$IPTABLES -P INPUT ACCEPT
$IPTABLES -P FORWARD ACCEPT
$IPTABLES -P OUTPUT ACCEPT

# Deny IPv6 connections 
$IP6TABLES -P INPUT DROP 
$IP6TABLES -P FORWARD DROP
$IP6TABLES -P OUTPUT DROP  
