#!/bin/bash

HELP_MESSAGE="This script can be used to automate the boring part of setting up your own machine for development.\n\nThis script includes the setup for different development environments and utilities like:\n\n  - Android App <React Native>\n  - Shells <Zsh>\n  - IDEs <Pycharm, VS Code>\n  - Containers <Docker>\n  - Tools <Postman>\n  - Communication <WhatsApp>\n  - Privacy <Tor>\n\nUsage:\n  --react-native: for android app development\n  --zsh: for using ZSH as default\n  --all: to get all the development environments installed\n  --pycharm: to install Pycharm IDE\n  --code: to install Visual Studio Code\n  --docker: to install Docker\n  --postman: to install Postman\n  --whatsapp: to install WhatsApp\n  --tor: to install Tor Browser\n  --recommended: to install recommended tools\n  --me: custom setup\n  --mine: custom setup\n  --help: display this help message"

if test -f "/etc/debian_version"; then
    export OS_TYPE="Ubuntu"
    echo "Detected Ubuntu"
else
    OS_NAME=$(grep '^NAME=' /etc/os-release)
    ARCH_LINUX_OS_RELEASE_STRING="NAME=\"Arch Linux\""
    if [ "$OS_NAME" == "$ARCH_LINUX_OS_RELEASE_STRING" ]; then
        export OS_TYPE="Arch"
        echo "Detected Arch Linux"
    else
        echo "Unknown Operating System Detected. This script only supports Arch Linux or Ubuntu"
        exit 123
    fi
fi

for var in "$@"; do
    case $var in
    "--help")
        echo -e "$HELP_MESSAGE"
        exit 0
        ;;
    "--me")
        export CURRENT_USER="ME"
        ;;
    "--all")
        export OPTIONS="ALL"
        break
        ;;
    "--pycharm")
        if [ -n "$OPTIONS" ]; then
            export OPTIONS="$OPTIONS:PYCHARM"
        else
            export OPTIONS="PYCHARM"
        fi
        export PYCHARM="true"
        ;;
    "--react-native")
        if [ -n "$OPTIONS" ]; then
            export OPTIONS="$OPTIONS:REACT_NATIVE"
        else
            export OPTIONS="REACT_NATIVE"
        fi
        export REACT_NATIVE="true"
        ;;
    "--zsh")
        if [ -n "$OPTIONS" ]; then
            export OPTIONS="$OPTIONS:ZSH"
        else
            export OPTIONS="ZSH"
        fi
        export ZSH="true"
        ;;
    "--mine" | "--me")
        if [ -n "$OPTIONS" ]; then
            export OPTIONS="$OPTIONS:MINE"
        else
            export OPTIONS="MINE"
        fi
        export MINE="true"
        ;;
    "--code")
        if [ -n "$OPTIONS" ]; then
            export OPTIONS="$OPTIONS:CODE"
        else
            export OPTIONS="CODE"
        fi
        export CODE="true"
        ;;
    "--docker")
        if [ -n "$OPTIONS" ]; then
            export OPTIONS="$OPTIONS:DOCKER"
        else
            export OPTIONS="DOCKER"
        fi
        export DOCKER="true"
        ;;
    "--postman")
        if [ -n "$OPTIONS" ]; then
            export OPTIONS="$OPTIONS:POSTMAN"
        else
            export OPTIONS="POSTMAN"
        fi
        export POSTMAN="true"
        ;;
    "--whatsapp")
        if [ -n "$OPTIONS" ]; then
            export OPTIONS="$OPTIONS:WHATSAPP"
        else
            export OPTIONS="WHATSAPP"
        fi
        export WHATSAPP="true"
        ;;
    "--tor")
        if [ -n "$OPTIONS" ]; then
            export OPTIONS="$OPTIONS:TOR"
        else
            export OPTIONS="TOR"
        fi
        export TOR="true"
        ;;
    "--recommended")
        if [ -n "$OPTIONS" ]; then
            export OPTIONS="$OPTIONS:RECOMMENDED"
        else
            export OPTIONS="RECOMMENDED"
        fi
        export RECOMMENDED="true"
        ;;
    *)
        export $var="true"
        ;;
    esac
done
