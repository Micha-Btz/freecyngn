#!/sbin/sh

#disable captive portal login
pm disable com.android.captiveportallogin
settings put global captive_portal_detection_enabled 0
settings put global captive_portal_server localhost
settings put global captive_portal_mode 0

# Disable Global NTP Server
settings put global ntp_server 131.188.3.222
