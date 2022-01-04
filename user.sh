#!/bin/bash

# Appearance pacakges

#Ms-fonts
sudo apt install ttf-mscorefonts-installer

#-------------wallpaper
mkdir -p $HOME/Pictures/wallpaper
cd $HOME/Pictures/wallpaper
git clone https://github.com/waso99/Debian-titus/tree/main/wallpaper

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

#------------- pureline
mkdir -p $HOME/pureline

# Layan Cursors
#mkdir -p $HOME/build
#cd "$HOME/build"
#git clone https://github.com/vinceliuice/Layan-cursors
#cd Layan-cursors
#sudo ./install.sh
