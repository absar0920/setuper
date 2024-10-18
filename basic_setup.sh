#!/bin/bash
set -e

if [ "$OS_TYPE" == "Ubuntu" ]; then
    bash scripts/basic_setup_deb.sh
else
    bash scripts/basic_setup_arch.sh
fi
