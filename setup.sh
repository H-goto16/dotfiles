#!/bin/bash

echo -n "Input git Name: "
read gitName
echo -n "Input git Email: "
read gitEmail

sudo pacman -Syu --needed - < pkglist/base.txt --noconfirm

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm

yay -S - < "$(dirname "${BASH_SOURCE[0]}")/pkglist/app.txt" --noconfirm


mkdir -p ~/.ssh && cd ~/.ssh

ssh-keygen -t rsa

touch ~/.ssh/config

echo "Host *
    IPQoS=0x00" >> ~/.ssh/config

git config --global user.email "$gitEmail"
git config --global user.name "$gitName"

sudo cp ~/dotfiles/fcitx/environment /etc/environment

cp /etc/X11/xinit/xserverrc ~/.xserverrc

cat ~/.ssh/id_rsa.pub
