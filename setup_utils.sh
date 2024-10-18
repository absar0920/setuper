#!/bin/bash

HELP_MESSAGE="This script can be used to automate the boring part of setting up your own machine for development.\n\nThis script includes the setup for different development environments and utilities like:\n\n  - Android App <React Native>\n  - Shells <Zsh>\n\nUsage:\n  --react-native: for android app development\n  --zsh: for using ZSH as default\n  --all: to get all the development environments installed"

if test -f "/etc/debian_version"
then
    export OS_TYPE="Ubuntu"
    echo "Detected Ubuntu"
else
    OS_NAME=$(grep '^NAME=' /etc/os-release)
    ARCH_LINUX_OS_RELEASE_STRING="NAME=\"Arch Linux\""
    if [ "$OS_NAME" == "$ARCH_LINUX_OS_RELEASE_STRING" ];
    then
        export OS_TYPE="Arch"
        echo "Detected Arch Linux"
    else
        echo "Unknown Operating System Detected. This script only supports Arch Linux or Ubuntu"
        exit 123
    fi
fi

for var in "$@"
do
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
            if [ -n "$OPTIONS" ]
            then
                export OPTIONS="$OPTIONS:PYCHARM"
            else
                export OPTIONS="PYCHARM"
            fi
            export PYCHARM="true"
        ;;
        "--react-native")
            if [ -n "$OPTIONS" ]
            then
                export OPTIONS="$OPTIONS:REACT_NATIVE"
            else
                export OPTIONS="REACT_NATIVE"
            fi
            export REACT_NATIVE="true"
         ;;
         "--zsh")
            if [ -n "$OPTIONS" ]
            then
                export OPTIONS="$OPTIONS:ZSH"
            else
                export OPTIONS="ZSH"
            fi
            export ZSH="true"
         ;;
         "--mine")
            if [ -n "$OPTIONS" ]
            then
                export OPTIONS="$OPTIONS:MINE"
            else
                export OPTIONS="MINE"
            fi
            export MINE="true"
         ;;
        *) 
            export $var="true"
        ;;
    esac
done