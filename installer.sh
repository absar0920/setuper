#!/bin/bash
set -e

if [ "$OS_TYPE" == "Ubuntu" ]; then
    bash scripts/installer/deb.sh
else
    bash scripts/installer/arch.sh
fi
