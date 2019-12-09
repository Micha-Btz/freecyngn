#!/sbin/sh

#enable captive portal login
pm enable com.android.captiveportallogin
settings put global captive_portal_detection_enabled 1
settings put global captive_portal_mode 1

settings put global captive_portal_http_url "http://captiveportal.kuketz.de"
settings put global captive_portal_https_url "https://captiveportal.kuketz.de"
settings put global captive_portal_fallback_url "http://captiveportal.kuketz.de"
settings put global captive_portal_other_fallback_urls "http://captiveportal.kuketz.de"


$IPTABLES -A "afwall" -d 188.68.35.146 -p tcp --dport 80 -j ACCEPT 
$IPTABLES -A "afwall" -d 188.68.35.146 -p tcp --dport 443 -j ACCEPT


