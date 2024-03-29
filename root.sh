#!/bin/bash

# Change Debian to SID Branch
cp /etc/apt/sources.list /etc/apt/sources.list.bak
cp sources.list /etc/apt/sources.list 

username=$(id -u -n 1000)
builddir=$(pwd)

# Add Custom Titus Rofi Deb Package
dpkg -i 'Custom Packages/rofi_1.7.0-1_amd64.deb'

# download lsd
wget -qO - https://api.github.com/repos/Peltoche/lsd/releases/latest \
| grep browser_download_url \
| grep amd64 \
| cut -d  '"' -f 4  \
| wget -cqi - -O lsd.deb

dpkg -i lsd.deb

# Update packages list
apt update

# Add base packages
apt install xorg bashtop psmisc firefox gedit unzip picom i3 polybar nitrogen rofi kitty terminator thunar neovim neofetch sxhkd lxpolkit lxappearance -y
apt install conky-all ttf-mscorefonts-installer papirus-icon-theme fonts-noto-color-emoji fonts-firacode fonts-font-awesome libqt5svg5 qml-module-qtquick-controls bmon network-manager network-manager-gnome -y

# Download Karitim-Dark-GTK Theme
cd /usr/share/themes/
#git clone https://github.com/EliverLara/Nordic.git
#git clone https://github.com/waso99/Karitim-Dark-GTK.git

# Fira Code Nerd Font variant needed
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v1.1.0/FiraCode.zip
unzip FiraCode.zip -d /usr/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v1.1.0/Meslo.zip
unzip Meslo.zip -d /usr/share/fonts
fc-cache -vf

#Autologin (waso)
mkdir /etc/systemd/system/getty@tty1.service.d
cd /etc/systemd/system/getty@tty1.service.d
wget https://raw.githubusercontent.com/waso99/Debian-titus/main/override.conf

cd $builddir
mkdir -p /home/$username/.config
cp .Xresources /home/$username
cp .Xnord /home/$username
cp -R dotfiles/* /home/$username/.config/
chown -R $username:$username /home/$username
