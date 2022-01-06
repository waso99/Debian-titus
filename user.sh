#!/bin/bash

# Appearance pacakges

#-------------wallpaper
mkdir -p $HOME/Pictures/wallpaper
cp $HOME/Debian-titus/wallpaper/* $HOME/Pictures/wallpaper

#------------- Neovim setting

mkdir -p $HOME/.config/nvim
mkdir -p $HOME/.config/nvim/autoload
cd $HOME/.config/nvim/autoload
wget https://raw.githubusercontent.com/waso99/Neovim/main/plug.vim
cd $HOME/.config/nvim/
wget https://raw.githubusercontent.com/waso99/Neovim/main/init.vim
cd $HOME
wget https://raw.githubusercontent.com/waso99/Neovim/main/.vimrc
nvim .vimrc +PlugInstall +qall


#-------------Startx Automatically
printf "if [[ -z "$DISPLAY" ]] && [[ $(tty) = /dev/tty1 ]]; then
 . startx
 logout
fi" >> $HOME/.profile


#------------- pureline
mkdir -p $HOME/pureline

# Layan Cursors
#mkdir -p $HOME/build
#cd "$HOME/build"
#git clone https://github.com/vinceliuice/Layan-cursors
#cd Layan-cursors
#sudo ./install.sh
