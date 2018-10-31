#!/bin/bash

#Gets sudo permission for the script at the beginning
if [ $EUID != 0 ]; then
    sudo "$0" "$@"
    exit $?
fi

cd "$HOME"/rtlwifi_new
make clean
git pull
make clean && make
sudo make install

sudo modprobe -r rtl8723be
sudo modprobe rtl8723be ant_sel=2
