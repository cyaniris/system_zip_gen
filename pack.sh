#!/bin/bash

if [ "$(id -u)" != "0" ]; then
  echo 'This script must be run as root'
  exit 1
fi

if [ ! -d system -o ! -d META-INF ]; then
  echo 'Oops wrong dir or something is missing!'
  exit 1
fi

cd system
../bin/gen.sh > ../META-INF/com/google/android/updater-script
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


