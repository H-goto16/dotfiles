#!/bin/bash

# Node.js
nvm install stable
npm i -g yarn
# Docker
sudo pacman -Sy docker docker-compose --noconfirm
sudo usermod -aG docker $USER 
sudo systemctl enable docker

# flutter
yay -S flutter android-studio --noconfirm
sudo pacman -Sy dart android-tools --noconfirm

sudo chown -R $USER /opt/flutter
export PATH="$PATH:/opt/flutter/bin"
export CHROME_EXECUTABLE=/usr/bin/google-chrome-stable

# Python
sudo pacman -Sy python python-pip --noconfirm

# sam
yay -S aws-sam-cli --noconfirm