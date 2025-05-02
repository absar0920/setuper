#!/bin/bash
set -e

sudo pacman -Syu --noconfirm # Update system and packages
sudo pacman -S --noconfirm curl wget git unzip neofetch ncdu htop nethogs base-devel feh fzf xclip playerctl xorg-xbacklight brightnessctl scrot flameshot xorg-xinput

script_dir=$(pwd)
source .env

# Install snapd
sudo -u $MACHINE_USER git clone https://aur.archlinux.org/snapd.git /tmp/snapd
cd /tmp/snapd
sudo -u $MACHINE_USER makepkg -si --noconfirm
cd $script_dir
rm -rf /tmp/snapd
sudo systemctl enable --now snapd.socket # not working

sudo pacman -S --noconfirm python python-pip python-virtualenv tmux

# wine # not working
sudo pacman -S --noconfirm nodejs npm yarn unrar p7zip openvpn

sudo pacman -S --noconfirm gparted

sudo pacman -S --noconfirm gimp vlc

# install yay
sudo -u $MACHINE_USER git clone https://aur.archlinux.org/yay.git /tmp/yay
cd /tmp/yay
sudo -u $MACHINE_USER makepkg -si --noconfirm
cd ..
rm -rf yay
cd $script_dir

# Install Slack (AUR)
sudo -u $MACHINE_USER yay -S --noconfirm slack-desktop

# Install Zoom (AUR)
sudo -u $MACHINE_USER yay -S --noconfirm zoom


# Linux WiFi Hotspot
sudo pacman -S --noconfirm gtk3 base-devel gcc pkgconf make hostapd qrencode libpng
sudo -u $MACHINE_USER git clone https://github.com/lakinduakash/linux-wifi-hotspot /tmp/linux-wifi-hotspot
cd /tmp/linux-wifi-hotspot
make
sudo make install
cd ..
rm -rf linux-wifi-hotspot
cd $script_dir

source .env

# sudo -u $MACHINE_USER HOME=/home/$MACHINE_USER USER=$MACHINE_USER bash $script_dir/scripts/programs/nvm.sh

# Browser installations
sudo pacman -S --noconfirm firefox
sudo -u $MACHINE_USER yay -S --noconfirm google-chrome
sudo -u $MACHINE_USER yay -S --noconfirm brave-bin

# Install Nerd Fonts
wget -P /home/$MACHINE_USER/.local/share/fonts https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/0xProto.zip &&
   cd /home/$MACHINE_USER/.local/share/fonts &&
   unzip -o 0xProto.zip &&
   rm 0xProto.zip &&
   fc-cache -fv
cd $script_dir