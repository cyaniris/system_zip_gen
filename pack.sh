#!/bin/bash

if [ "$(id -u)" != "0" ]; then
  echo 'This script must be run as root'
  exit 1
fi

if [ ! -d system -o ! -d META-INF ]; then
  echo 'Oops wrong dir or something is missing!'
  exit 1
fi

echo -n -e '\nCreate?(N/y): '
read a
if [ "a$a" == 'ay' -o "a$a" == 'aY' ]; then
  cd system
  ../bin/gen.sh > ../META-INF/com/google/android/updater-script
  cd ..

  rm -f _t.zip
  find system   -type f -prune | zip -0 -u _t.zip -@
  find META-INF -type f -prune | zip -0    _t.zip -@
fi

if [ -f _t.zip ]; then
  echo -n -e "\nSign?(N/y): "
  read a
  if [ "a$a" == 'ay' -o "a$a" == 'aY' ]; then

    ID=$(grep ro.build.display.id  system/build.prop | sed 's/ //g')
    ID=${ID##*.}
    
    test -f "system-${ID}.zip" && rm "system-${ID}.zip"

    echo -e "\nSigning zip..."
    java -jar bin/signapk.jar bin/testkey.x509.pem bin/testkey.pk8 _t.zip "system-${ID}.zip"

    if [ -f "system-${ID}.zip" ]; then
      chmod 666 "system-${ID}.zip"
      echo -e "\nZip is ready!!"
    fi

  fi
fi

echo

