#!/bin/bash

read -p "Enter your git email: " gitEmail
read -p "Enter your git name: " gitName

if [ -z "$gitEmail" ] || [ -z "$gitName" ]; then
    gitEmail="h.goto.engineer@gmail.com"
    gitName="H-goto16"
fi

git config --global user.email "$gitEmail"
git config --global user.name "$gitName"

sudo pacman -Syu --needed - < pkglist/base.txt --noconfirm

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm

yay -S - < pkglist/app.txt --noconfirm

mkdir -p ~/.ssh && cd ~/.ssh

ssh-keygen -t rsa

touch ~/.ssh/config

echo "Host *
    IPQoS=0x00" >> ~/.ssh/config

sudo cp ~/dotfiles/fcitx/environment /etc/environment

cp /etc/X11/xinit/xserverrc ~/.xserverrc

cat ~/.ssh/id_rsa.pub | xclip -selection clipboard
google-chrome-stable https://github.com/settings/keys
