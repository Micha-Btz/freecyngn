#!/sbin/sh
# /system/addon.d/20-freecyngn.sh
# During a LineageOS upgrade this script repatches the rom
# using the freecyngn patchset.
#

deleteApk() {
    rm -rf /system/app/$1.apk /system/priv-app/$1.apk /system/app/$1 /system/priv-app/$1 && echo "Removed $1"
}

del_files() {
cat <<EOF
BasicDreams
CaptivePortalLogin
Email
Exchange2
Gallery2
Jelly
LineageBlackAccent
LineageBlackTheme
LineageBlueAccent
LineageBrownAccent
LineageCyanAccent
LineageDarkTheme
LineageGreenAccent
LineageOrangeAccent
LineagePinkAccent
LineagePurpleAccent
LineageRedAccent
LineageYellowAccent
LiveWallpapersPicker
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
