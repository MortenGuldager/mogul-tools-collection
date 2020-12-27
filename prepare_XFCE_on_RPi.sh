#!/bin/bash

# https://www.pragmaticlinux.com/2020/11/install-the-xfce-desktop-on-your-raspberry-pi/

set -e

sudo apt install -y xserver-xorg xfce4 xfce4-goodies

sudo systemctl set-default graphical.target
sudo dpkg-reconfigure lightdm

sudo update-alternatives --config x-session-manager

sudo update-alternatives  --set x-session-manager /usr/bin/startxfce4

sudo update-alternatives  --set x-window-manager /usr/bin/xfwm4

sudo sed -i "s/\(greeter-hide-users=\).*/\1false/g"  /usr/share/lightdm/lightdm.conf.d/01_debian.conf
sudo sed -i "s/.*\(disable_overscan=\).*/\11/g"  /boot/config.txt
