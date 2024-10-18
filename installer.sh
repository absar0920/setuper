#!/bin/bash
set -a # to stop the script if any errors occurs

if [ "$OS_TYPE" == "Ubuntu" ]; then
    bash scripts/installer/deb.sh
else
    bash scripts/installer/arch.sh
fi
