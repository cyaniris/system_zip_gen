#!/bin/bash

echo 'ui_print("");
ui_print("");
ui_print(" ###################### ");
ui_print("     GT-I9502ZNUCMH2    ");
ui_print("   with ROOT and GAPPS  ");
ui_print("      by Nightfire      ");
ui_print(" ###################### ");
ui_print("");
ui_print("");
show_progress(1.000000, 0);'
echo

echo 'ui_print("--------------------");
ui_print(" Clean up /preload...");
ui_print("--------------------");
mount("ext4", "EMMC", "/dev/block/mmcblk0p16", "/preload");
delete_recursive("/preload");'
echo 'set_progress(0.100000);'
echo

echo 'ui_print("--------------------");
ui_print(" Wipe Cache...");
ui_print("--------------------");
mount("ext4", "EMMC", "/dev/block/mmcblk0p19", "/cache");
delete_recursive("/cache");'
echo 'set_progress(0.200000);'
echo

echo 'ui_print("--------------------");
ui_print(" Wipe Dalvik Cache...");
ui_print("--------------------");
mount("ext4", "EMMC", "/dev/block/mmcblk0p21", "/data");
delete_recursive("/data/dalvik-cache");'
echo 'set_progress(0.300000);'
echo

echo 'ui_print("--------------------");
ui_print(" Format /system...");
ui_print("--------------------");
format("ext4", "EMMC", "/dev/block/mmcblk0p20", "0");
mount("ext4", "EMMC", "/dev/block/mmcblk0p20", "/system");
delete_recursive("/system");'
echo 'set_progress(0.400000);'
echo

echo 'ui_print("--------------------");
ui_print("Copying System...");
package_extract_dir("system", "/system");'
echo 'set_progress(0.700000);'
echo

echo 'ui_print("--------------------");
ui_print(" Make Links...");
ui_print("--------------------");'
find . -type l -exec ls -l {} \; | cut -d' ' -f10,12 | sort | while read a b
do
  echo "symlink(\"$b\", \"/system${a#.}\");"
done
echo 'set_progress(0.800000);'
echo

echo 'ui_print("--------------------");
ui_print(" Set Permissions...");
ui_print("--------------------");'
find . -type f ! -perm 644 | sort | while read FILE
do
  U=$( stat -c "%u" $FILE )
  G=$( stat -c "%g" $FILE )
  A=$( stat -c "%a" $FILE )
  echo "set_perm($U, $G, 0$A, \"/system${FILE#.}\");"
done
echo 'set_progress(0.900000);'
echo

echo 'unmount("/cache");
unmount("/data");
unmount("/preload");
unmount("/system");
set_progress(1.000000);
ui_print("Done, your system is MINE!!!");'
echo

echo 'ui_print("");
ui_print("");
ui_print(" ###################### ");
ui_print("     GT-I9502ZNUCMH2    ");
ui_print("   with ROOT and GAPPS  ");
ui_print("      by Nightfire      ");
ui_print(" ###################### ");
ui_print("");
ui_print("");
show_progress(1.000000, 0);'

