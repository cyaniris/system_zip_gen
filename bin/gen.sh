#!/bin/bash

idinc=$(grep ro.build.display.id  build.prop)
idinc=${idinc##*.}

echo "ui_print(\"\");
ui_print(\"\");
ui_print(\"************************\");
ui_print(\"     GT-${idinc}    \");
ui_print(\"   with ROOT and GAPPS  \");
ui_print(\"       by Cyaniris      \");
ui_print(\"************************\");
ui_print(\"\");
ui_print(\"\");
show_progress(1.0, 0);"
echo

echo 'ui_print("------------------------");
ui_print(" Formating /system...   ");
format("ext4", "EMMC", "/dev/block/mmcblk0p20", "0", "/system");
mount("ext4", "EMMC", "/dev/block/mmcblk0p20", "/system");
delete_recursive("/system");'
echo 'set_progress(0.1);'
echo

echo 'ui_print("------------------------");
ui_print(" Copying System...      ");
package_extract_dir("system", "/system");'
echo 'set_progress(0.5);'
echo

echo 'ui_print("------------------------");
ui_print(" Making Symbol Links... ");'
find . -type l -exec sh -c 'echo `readlink {}` {}' \; | sort | while read b a
do
  echo "symlink(\"$b\", \"/system${a#.}\");"
done
echo 'set_progress(0.6);'
echo

# We don't need to care about ownership
# because only two files have non-root
# owner, while both have special permission

echo 'ui_print("------------------------");
ui_print(" Setting Permissions... ");'
find . -type f ! -perm 644 | sort | while read FILE
do
  U=$( stat -c "%u" $FILE )
  G=$( stat -c "%g" $FILE )
  A=$( stat -c "%a" $FILE )
  echo "set_perm($U, $G, 0$A, \"/system${FILE#.}\");"
done
echo 'set_progress(0.7);'
echo

echo 'ui_print("------------------------");
ui_print(" Cleaning up /preload...");
mount("ext4", "EMMC", "/dev/block/mmcblk0p16", "/preload");
delete_recursive("/preload");'
echo 'set_progress(0.8);'
echo

echo 'ui_print("------------------------");
ui_print(" Wiping Cache...        ");
mount("ext4", "EMMC", "/dev/block/mmcblk0p19", "/cache");
delete_recursive("/cache");'
echo 'set_progress(0.9);'
echo

echo 'ui_print("------------------------");
ui_print(" Wiping Dalvik Cache... ");
mount("ext4", "EMMC", "/dev/block/mmcblk0p21", "/data");
delete_recursive("/data/dalvik-cache");'
echo 'set_progress(1.0);'
echo

echo 'unmount("/cache");
unmount("/data");
unmount("/preload");
unmount("/system");
ui_print("------------------------");
ui_print("");
ui_print("");
ui_print("************************");
ui_print("    Done, your system   ");
ui_print("       is MINE!!!!      ");
ui_print("************************");
ui_print("");
ui_print("");'
echo

