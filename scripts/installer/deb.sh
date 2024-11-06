#!/bin/bash

set -e

source ./setup_utils.sh "$@"

if [ "$REACT_NATIVE" == "true" -o "$OPTIONS" == "all" ]; then
    sudo apt install default-jre default-jdk -y
    sudo snap install android-studio --classic
    sudo npm install -g react-native-cli
fi

if [ "$PYCHARM" == "true" -o "$OPTIONS" == "all" -o "$MINE" == "true" -o "$RECOMMENDED" == "true" ]; then
    sudo snap install pycharm-professional --classic
    sudo apt install postgresql -y
fi

if [ "$ZSH" == "true" -o "$MINE" == "true" ]; then
    sudo apt-get install zsh -y
fi

if [ "$CODE" == "true" -o "$MINE" == "true" -o "$RECOMMENDED" == "true" -o "$OPTIONS" == "all" ]; then
    echo "INSTALLING VSCODE..."
    sudo snap install code --classic
fi

if [ "$DOCKER" == "true" -o "$OPTIONS" == "all" -o "$MINE" == "true" -o "$RECOMMENDED" == "true" ]; then
    sudo apt-get install apt-transport-https ca-certificates curl software-properties-common -y
    sudo apt install docker.io docker-compose -y
    sudo usermod -aG docker $USER
fi

if [ "$POSTMAN" == "true" -o "$OPTIONS" == "all" -o "$MINE" == "true" -o "$RECOMMENDED" == "true" ]; then
    echo "INSTALLING POSTMAN..."
    sudo snap install postman
fi

if [ "$MINE" == "true" -o "$WHATSAPP" == "true" -o "$RECOMMENDED" == "true" -o "$OPTIONS" == "all" ]; then
    echo "INSTALLING WHATSAPP..."
    sudo snap install whatsie
    sudo snap install whatsdesk
fi

if [ "$TOR" == "true" -o "$MINE" == "true" ]; then
    sudo apt-get install tor torbrowser-launcher -y
fi

# TODO: pnpm
npm install -g pnpm


if [ "$MINE" == "true" ]; then
    echo "wireshark-common wireshark-common/install-setuid boolean true" | sudo debconf-set-selections
    sudo DEBIAN_FRONTEND=noninteractive apt-get install wireshark -y
    sudo apt-get install curl -y
    sudo apt-get install speedtest-cli alsamixergui -y
    sudo apt-get install rustc cargo golang -y
    sudo snap install obsidian --classic
    sudo apt-get install obs-studio -y

    sudo apt-get install aria2 -y

    # install thorium browser, opera, vivaldi, mercury
    wget https://dl.thorium.rocks/debian/dists/stable/thorium.list
    sudo mv thorium.list /etc/apt/sources.list.d/
    sudo apt update -y
    sudo apt install thorium-browser -y
    sudo sh -c 'echo "deb [arch=amd64] https://deb.opera.com/opera-stable/ stable non-free" > /etc/apt/sources.list.d/opera.list'
    wget -O - https://deb.opera.com/archive.key | sudo apt-key add -
    sudo apt-get update -y
    sudo DEBIAN_FRONTEND=noninteractive apt-get install opera-stable -y
    sudo snap install vivaldi

    bash scripts/installer/my/script_deb.sh
fi

