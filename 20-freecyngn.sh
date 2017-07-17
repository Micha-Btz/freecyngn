#!/sbin/sh
#
# /system/addon.d/20-freecyngn.sh
# During a CyanogenMod upgrade this script repatches CyanogenMod
# using the freecyngn patchset.
#

deleteApk() {
    rm -rf /system/app/$1.apk /system/priv-app/$1.apk /system/app/$1 /system/priv-app/$1 && echo "Removed $1"
}

del_files() {
cat <<EOF
BasicDreams
Browser
privacy-browser
CaptivePortalLogin
CMAccount
CMFileManager
CMS
CMSetupWizard
CMUpdater
CyanogenSetupWizard
Email
Exchange2
HoloSpiral
HoloSpiralWallpaper
LivePicker
LiveWallpapers
LiveWallpapersPicker
MagicSmoke
MusicVisualization
NoiseField
PhaseBeam
PhotoPhase
PhotoTable
SetupWizard
TimeService
VisualizationWallpapers
Voice+
VoiceDialer
VoicePlus
WebView
WhisperPush
EOF
}

if [[ "$1" == "post-restore" ]] || [[ "$1" == "" ]]; then
    del_files | while read FILE; do
        deleteApk "$FILE"
    done
fi

#set captive_portal_detection_enabled 0
settings put global captive_portal_detection_enabled 0
settings put global captive_portal_server localhost
settings put global captive_portal_mode 0

# remove guest user - make sure you deleted all guest user before
settings put global guest_user_enabled 0
mount -o rw,remount,rw /system
cp /system/build.prop /system/build.prop.old
echo "fw.max_users=1" >> /system/build.prop
echo "fw.show_multiuserui=0" >> /system/build.prop
mount -o ro,remount,ro /system

