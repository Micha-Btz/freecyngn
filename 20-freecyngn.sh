#!/sbin/sh
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
privacy-browser
CaptivePortalLogin
CMFileManager
CMWallpapers
CyanogenSetupWizard
Email
Exchange2
HoloSpiralWallpaper
LivePicker
LiveWallpapers
LiveWallpapersPicker
NoiseField
PhaseBeam
PhotoPhase
PhotoTable
VisualizationWallpapers
EOF
}

if [[ "$1" == "post-restore" ]] || [[ "$1" == "" ]]; then
    del_files | while read FILE; do
        deleteApk "$FILE"
    done
fi

# remove guest user - make sure you deleted all guest user before
if (grep -q "fw.max_users=1" /system/build.prop );
        then
        echo "max users already set"
        exit 1;
    else
    cp /system/build.prop /system/build.prop.old;
    echo "fw.max_users=1" >> /system/build.prop;
    echo "fw.show_multiuserui=0" >> /system/build.prop;
fi
