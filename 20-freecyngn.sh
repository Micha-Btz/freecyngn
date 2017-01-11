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

TEST=`settings get global captive_portal_detection_enabled`
if [ "$TEST" -eq "0" ];
    then
    echo variable is set to zero
    else 
     settings put global captive_portal_detection_enabled 0
fi



=======
# Needed due to the removal of CyanogenSetupWizard.
# Without, the home button and quick settings are broken.
/system/xbin/sqlite3 /data/user_de/0/org.cyanogenmod.cmsettings/databases/cmsettings.db "update secure set value = 1 where name = 'cm_setup_wizard_completed';"
