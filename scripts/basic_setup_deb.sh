#!/bin/bash
set -e

sudo dpkg --configure -a # fix broken packages
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install -y curl wget git unzip neofetch ncdu htop nethogs build-essential feh fzf xclip

sudo apt-get install snapd -y

sudo apt-get install python3 python3-pip python3-venv wine tmux -y

sudo apt-get install nodejs npm yarn rar p7zip openvpn -y

sudo apt-get install gparted -y

sudo snap install vlc gimp slack zoom-client

source .env

script_dir=`pwd`

# sudo -u $MACHINE_USER HOME=/home/$MACHINE_USER USER=$MACHINE_USER bash $script_dir/scripts/programs/nvm.sh

wget -P /home/$MACHINE_USER/.local/share/fonts https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/0xProto.zip \
&& cd /home/$MACHINE_USER/.local/share/fonts \
&& unzip -o 0xProto.zip \
&& rm 0xProto.zip \
&& fc-cache -fv
cd $script_dir
