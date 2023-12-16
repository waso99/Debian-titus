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

### **method 1**
copy content to local hardisk (example: "VBoxGuest")
```
sudo -i
chmod -R 777 VBoxGuest
cd VBoxGuest
./VBoxLinuxAdditions.run
```
### **method 2**
1. Login as root: ```sudo -i```
2. Update your APT database with: ```apt-get update```
3. Install the latest security updates with: ```apt-get upgrade```
4. Install required packages with: ```apt-get install build-essential module-assistant```
5. Configure your system for building kernel modules by running: ```m-a prepare```
6. Click on Install Guest Additions… from the Devices menu, then run ```mount /media/cdrom```
7. Run ```sh /media/cdrom/VBoxLinuxAdditions.run```, and follow the instructions on screen.

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

3- add the following two lines to ``` /etc/sudoers```
```
ALL ALL=(ALL) NOPASSWD: /opt/brightctl --brighter
ALL ALL=(ALL) NOPASSWD: /opt/brightctl --dimmer
```
4- add the following two lines to ``` /etc/udev/rules.d/backlight.rules```

```
ACTION=="add", SUBSYSTEM=="backlight", RUN+="/bin/chgrp video $sys$devpath/brightness", RUN+="/bin/chmod g+w $sys$devpath/brightness"
```

5- add the following two lines to i3 config file:
```
bindsym XF86MonBrightnessUp exec /opt/brightctl --brighter
bindsym XF86MonBrightnessDown exec /opt/brightctl --dimmer
```

## Auto login 
### with lightdm:
```sudo nano /etc/lightdm/lightdm.conf```<br>
then remove the # tag from:
```
autologin-guest=false
autologin-user=waso
autologin-user-timeout=0
```
### with Gnome:
```sudo nano /etc/gdm3/daemon.conf```<br>
then remove the # tag from:
```
[daemon]
AutomaticLoginEnable=True
AutomaticLogin=waso
```

## Install Zsh and oh my zsh and powerlevel10 theme
1. Install zsh
```
 sudo apt install zsh -y
```
2. Set zsh as default
```
chsh -s $(which zsh)
```
3. Install oh my zsh
```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```
4. install powerlevel10k
```
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```
5. Set ``` ZSH_THEME="powerlevel10k/powerlevel10k" ``` in ``` ~/.zshrc ```

## Set Time zon to Riyadh

```
sudo timedatectl set-timezone Asia/Riyadh
```

## Install latest release of neovim
```
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
```
```
chmod u+x nvim.appimage
```
```
sudo mv nvim.appimage /usr/local/bin/nvim
```
## fix (windows not showin in GRUB)
install os-prober
```
sudo apt install os-prober
```
```
sudo nano /etc/default/grub
```
then add or modify if exist
```
GRUB_DISABLE_OS_PROBER=false
```
```
sudo update-grub
```

then reboot.

## Install fonts

Place the fonts in ~/.fonts then

```
fc-cache -fv
```
## Connect wifi
list wifi:
```
nmcli device wifi list
```
Connect to a Wi-Fi network: 
```
nmcli device wifi connect SSID_or_BSSID password password
```

# Extract zip files in to its folders
```
find . -name '*.zip' -exec sh -c 'unzip -d "${1%.*}" "$1"' _ {} \;
```

# Thunar "Open Terminal Here" opens kitty:
creat file : ```~/.config/xfce4/helpers.rc```
add:
```
TerminalEmulator=kitty
TerminalEmulatorDismissed=true
```
