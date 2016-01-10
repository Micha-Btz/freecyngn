#!/sbin/sh
#
# /system/addon.d/20-freecyngn.sh
# During a CM10+ upgrade this script repatches CyanogenMod
# using the freecyngn patchset.
#

. /tmp/backuptool.functions

deleteApk() {
    rm -rf /system/app/$1.apk /system/priv-app/$1.apk /system/app/$1 /system/priv-app/$1 && echo "Removed $1"
}

del_files() {
cat <<EOF
BasicDreams
Browser
CaptivePortalLogin
CMAccount
CMS
CMSetupWizard
CyanogenSetupWizard
Voice+
VoiceDialer
VoicePlus
WhisperPush
Email
Exchange2
HoloSpiral
LivePicker
MagicSmoke
MusicVisualization
NoiseField
PhotoPhase
PhotoTable
WebView
SetupWizard
EOF
}

if [[ "$1" == "post-restore" ]] || [[ "$1" == "" ]]; then
    del_files | while read FILE; do
        deleteApk "$FILE"
    done
fi
