# Debian-titus
Debian customizations from Chris Titus Tech
 
## Requirements
_This install changes Debian to the SID (Dev) Branch_

### Download Debian non-free netinstall

Use the following Debian ISO as the base <https://cdimage.debian.org/cdimage/unofficial/non-free/cd-including-firmware/weekly-builds/amd64/iso-cd/>

*do NOT grab the EDU download and this includes non-free and firmware*
### Base Stuff - Root

_Run as ROOT_
```
sudo su
./root.sh
```

### Theme Stuff - User Level
 ```
 ./user.sh
 ```
## Addiing user for share folders permissions (Virtual Box)
 ```
sudo adduser $USER vboxsf
 ```

## Installing VirtualBox Guest Additions:

copy content to local hardisk (example: "VBoxGuest")
```
sudo -i
chmod -R 777 VBoxGuest
cd VBoxGuest
./VBoxLinuxAdditions.run
```

## Increase/Decrease Brightness F-keys on Keyboard

1- Run ```sudo nano /opt/brightctl``` and copy and paste in the following text:
```
#!/bin/bash

INCREMENT=50
MINIMUM=1
MAXIMUM=$(</sys/class/backlight/intel_backlight/max_brightness)

brightness=$(</sys/class/backlight/intel_backlight/brightness)

let brightness/=$INCREMENT
let brightness*=$INCREMENT

if test "_$1" = "_--brighter" ; then
  let brightness+=$INCREMENT
fi

if test "_$1" = "_--dimmer" ; then
  let brightness-=$INCREMENT
fi

if test $brightness -lt $MINIMUM ; then
  brightness=$MINIMUM
fi

if test $brightness -gt $MAXIMUM ; then
  brightness=$MAXIMUM
fi

echo $brightness > /sys/class/backlight/intel_backlight/brightness
```

2- Make the script executable with ```sudo chmod +x /opt/brightctl```

3- Run ```sudo nano /etc/sudoers``` and add the following two lines:
```
ALL ALL=(ALL) NOPASSWD: /opt/brightctl --brighter
ALL ALL=(ALL) NOPASSWD: /opt/brightctl --dimmer
```

4- add the following two lines to i3 config file:
```
bindsym XF86MonBrightnessUp exec /opt/brightctl --brighter
bindsym XF86MonBrightnessDown exec /opt/brightctl --dimmer
```
