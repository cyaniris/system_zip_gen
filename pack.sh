#!/bin/bash

#1M = 1024k/4k = 256 blocks
#dumpe2fs for orig number of blocks

#./bin/make_ext4fs -s -l 2100M -a system system-nonbloat.img system
#
#./bin/sgs4ext4fs --bloat system-nonbloat.img system.img
#
#rm system-nonbloat.img

cd system
../_updater_gen.sh > ../META-INF/com/google/android/updater-script
cd ..

7z a _system.zip META-INF system

echo -e "\nSigning zip..."
./bin/signzip.sh _system.zip

if [ -f _system-signed.zip ]; then
  rm _system.zip
  mv _system-signed.zip _system.zip
  chown yuanjie:yuanjie _system.zip
  echo -e "\nZip is ready!!\n"
fi


