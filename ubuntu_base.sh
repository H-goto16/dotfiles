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
git config --global core.editor vim

sudo apt update -y && sudo apt upgrade -y

sudo apt install -y zsh \
                    git \
                    vim \
                    curl \
                    software-properties-common \
                    apt-transport-https \
                    ca-certificates \
                    apt-transport-https \
                    gnome-software-plugin-flatpak \
                    gnome-shell-extension-manager \
                    libgtop2-dev \
                    wget \
                    gpg \
                    htop \
                    mpv

cd ./script

# install vscode
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg

# install google-chrome
curl -fSsL https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor | sudo tee /usr/share/keyrings/google-chrome.gpg > /dev/null
echo deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main | sudo tee /etc/apt/sources.list.d/google-chrome.list

# install warp terminal
sudo apt-get install wget gpg
wget -qO- https://releases.warp.dev/linux/keys/warp.asc | gpg --dearmor > warpdotdev.gpg
sudo install -D -o root -g root -m 644 warpdotdev.gpg /etc/apt/keyrings/warpdotdev.gpg
sudo sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/warpdotdev.gpg] https://releases.warp.dev/linux/deb stable main" > /etc/apt/sources.list.d/warpdotdev.list'
rm warpdotdev.gpg
sudo apt update && sudo apt install

# install brave
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list

# install spotify
curl -sS https://download.spotify.com/debian/pubkey_6224F9941A8AA6D1.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

# install docker
sh ./get-docker.sh
sudo gpasswd -a $USER docker

# install apps
sudo apt update -y
sudo apt install code google-chrome-stable warp-terminal brave spotify-client -y

# install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# install consolas font
sh ./install_consolas.sh

# install zsh
sh ./setup_zsh.sh

# git ssh
touch ~/.ssh/config
echo 'Host *
    IPQoS=0x00' >> ~/.ssh/config

ssh-keygen

snap install slack

cd -

