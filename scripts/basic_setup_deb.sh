#!/bin/bash

sudo dpkg --configure -a # fix broken packages
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install -y curl wget git unzip neofetch ncdu htop nethogs 

sudo apt-get install snapd -y

sudo apt-get install python3 python3-pip python3-venv wine tmux -y

sudo apt-get install nodejs npm yarn zoom rar p7zip openvpn -y

sudo apt-get install gparted -y

sudo snap install vlc gimp slack

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
source ~/.bashrc
nvm install node
nvm use node

wget -P ~/.local/share/fonts https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/0xProto.zip \
&& cd ~/.local/share/fonts \
&& unzip -o 0xProto.zip \
&& rm 0xProto.zip \
&& fc-cache -fv
