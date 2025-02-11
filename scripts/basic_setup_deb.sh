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

sudo apt-get install gimp vlc -y
wget https://downloads.slack-edge.com/desktop-releases/linux/x64/4.38.125/slack-desktop-4.38.125-amd64.deb
sudo apt install ./slack-desktop-4.38.125-amd64.deb -y && rm slack-desktop-4.38.125-amd64.deb
wget https://zoom.us/client/6.2.3.2056/zoom_amd64.deb
sudo apt install ./zoom_amd64.deb -y && rm zoom_amd64.deb

script_dir=$(pwd)

# linux wifi hotspot
sudo apt install -y libgtk-3-dev build-essential gcc g++ pkg-config make hostapd libqrencode-dev libpng-dev -y
git clone https://github.com/lakinduakash/linux-wifi-hotspot /tmp/linux-wifi-hotspot
cd /tmp/linux-wifi-hotspot
make
sudo make install
cd ..
rm -rf linux-wifi-hotspot
cd $script_dir

script_dir=$(pwd)

source .env

# sudo -u $MACHINE_USER HOME=/home/$MACHINE_USER USER=$MACHINE_USER bash $script_dir/scripts/programs/nvm.sh

# browser
sudo apt-get install firefox -y
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O /tmp/chrome.deb
sudo apt install /tmp/chrome.deb -y && rm /tmp/chrome.deb
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update -y
sudo apt install brave-browser -y

wget -P /home/$MACHINE_USER/.local/share/fonts https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/0xProto.zip &&
   cd /home/$MACHINE_USER/.local/share/fonts &&
   unzip -o 0xProto.zip &&
  rm 0xProto.zip &&
   fc-cache -fv
cd $script_dir
