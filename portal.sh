#!/sbin/sh
#
pm disable com.android.captiveportallogin
settings put global captive_portal_detection_enabled 0
settings put global captive_portal_server localhost
settings put global captive_portal_mode 0
