LANG=C xdg-user-dirs-gtk-update

rm -rf ~/ダウンロード ~/テンプレート ~/デスクトップ ~/ドキュメント ~/ビデオ ~/ピクチャ ~/ミュージック ~/公開

read -p "Enter your git email: " gitEmail
read -p "Enter your git name: " gitName


if [ -z "$gitEmail" ] || [ -z "$gitName" ]; then
    gitEmail="h.goto.engineer@gmail.com"
    gitName="H-goto16"
fi

git config --global user.email "$gitEmail"
git config --global user.name "$gitName"

sudo apt update -y && sudo apt upgrade -y

sudo apt install -y flatpak \
                    zsh \
                    git \
                    vim \
                    terminator \
                    curl \
                    software-properties-common \
                    apt-transport-https \
                    ca-certificates \
                    apt-transport-https \
                    gnome-software-plugin-flatpak \
                    wget \
                    gpg \
                    obs-studio \

# install vscode
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg

# install google-chrome
curl -fSsL https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor | sudo tee /usr/share/keyrings/google-chrome.gpg > /dev/null
echo deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main | sudo tee /etc/apt/sources.list.d/google-chrome.list

# install docker
sh get-docker.sh
sudo gpasswd -a $USER docker

# install apps
sudo apt update -y
sudo apt install code google-chrome-stable -y
snap install slack discord

# install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

nvm install stable
npm i -g yarn

# install consolas font
sh ./install_consolas.sh

# install zsh
sh ./setup_zsh.sh

# git ssh
touch ~/.ssh/config
echo 'Host *
    IPQoS=0x00' >> ~/.ssh/config

ssh-keygen
echo "\n\nCopy this key and paste to github.com\n"
cat ~/.ssh/id_rsa.pub
echo "\n"