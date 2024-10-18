#!/bin/bash

sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install -y curl wget git

sudo apt-get install snapd -y

sudo apt-get install python3 python3-pip python3-venv -y

sudo apt-get install nodejs npm -y

# vscode
sudo snap install code --classic

if [ "$REACT_NATIVE" == "true" -o "$OPTIONS" == "all" ]; then
    sudo apt install default-jre default-jdk -y
    # android studio
    sudo snap install android-studio --classic
    sudo npm install -g react-native-cli
fi

if [ "$PYCHARM" == "true" -o "$OPTIONS" == "all" ]; then
    sudo snap install pycharm-professional --classic
fi

if [ "$ZSH" == "true" -o "$MINE" == "true" ]; then
    sudo apt-get install zsh -y
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# sdkmanager "platform-tools" "platforms;android-28" "build-tools;28.0.3"
# sdkmanager --licenses
# sdkmanager --update
# sdkmanager --list
