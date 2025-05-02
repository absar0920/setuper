#!/bin/bash

set -e

source ./setup_utils.sh "$@"

if [ "$REACT_NATIVE" == "true" -o "$OPTIONS" == "all" ]; then
    sudo pacman -S --noconfirm jdk17-openjdk jre17-openjdk
    yay -S --noconfirm android-studio
    sudo npm install -g react-native-cli
fi

if [ "$PYCHARM" == "true" -o "$OPTIONS" == "all" -o "$MINE" == "true" -o "$RECOMMENDED" == "true" ]; then
    sudo pacman -S --noconfirm pycharm-community-edition
    sudo pacman -S --noconfirm postgresql
fi

if [ "$ZSH" == "true" -o "$MINE" == "true" ]; then
    sudo pacman -S --noconfirm zsh
fi

if [ "$CODE" == "true" -o "$MINE" == "true" -o "$RECOMMENDED" == "true" -o "$OPTIONS" == "all" ]; then
    echo "INSTALLING VSCODE..."
    sudo pacman -S --noconfirm code
fi

if [ "$DOCKER" == "true" -o "$OPTIONS" == "all" -o "$MINE" == "true" -o "$RECOMMENDED" == "true" ]; then
    sudo pacman -S --noconfirm docker docker-compose
    sudo usermod -aG docker $MACHINE_USER
    sudo systemctl enable --now docker
fi

if [ "$POSTMAN" == "true" -o "$OPTIONS" == "all" -o "$MINE" == "true" -o "$RECOMMENDED" == "true" ]; then
    echo "INSTALLING POSTMAN..."
    yay -S --noconfirm postman-bin
fi

if [ "$MINE" == "true" -o "$WHATSAPP" == "true" -o "$RECOMMENDED" == "true" -o "$OPTIONS" == "all" ]; then
    echo "INSTALLING WHATSAPP..."
    yay -S --noconfirm whatsie whatsdesk-bin
fi

if [ "$TOR" == "true" -o "$MINE" == "true" ]; then
    sudo pacman -S --noconfirm tor torbrowser-launcher
fi

# TODO: pnpm
npm install -g pnpm

if [ "$MINE" == "true" ]; then
    echo "wireshark-common wireshark-common/install-setuid boolean true" | sudo tee /dev/null
    sudo pacman -S --noconfirm wireshark-cli wireshark-qt
    sudo pacman -S --noconfirm curl
    sudo pacman -S --noconfirm speedtest-cli alsa-utils
    sudo pacman -S --noconfirm rust cargo go
    sudo pacman -S --noconfirm obs-studio

    sudo pacman -S --noconfirm aria2

    # Install Thorium Browser, Opera, Vivaldi, Mercury
    yay -S --noconfirm thorium-browser-bin
    yay -S --noconfirm opera
    sudo pacman -S --noconfirm vivaldi

    bash scripts/installer/my/script_arch.sh
fi