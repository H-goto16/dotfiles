#!/bin/bash

# Node.js

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

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