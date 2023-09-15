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
