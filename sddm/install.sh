#!/bin/bash 
echo "Please give the sudo password of your system for root permission"
sudo su
sudo pacman -S sddm
sudo systemctl enable sddm
mkdir -p /etc/sddm.conf.d/
touch -p /etc/sddm.conf.d/theme.conf.user
sudo cp -r nothing_sddm_theme/ /usr/share/sddm/themes/ 
cp theme.conf.user /etc/sddm.conf.d/
echo "Installed successfully"
