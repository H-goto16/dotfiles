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
                    mpv \
                    ntpdate \
                    flatpak \
                    gnome-software-plugin-flatpak

git config --global core.editor vim

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

cd ../script

# install vscode
flatpak install flathub com.visualstudio.code
# install google-chrome
flatpak install flathub com.google.Chrome
# install wezterm
# flatpak install flathub org.wezfurlong.wezterm
# install spotify
# flatpak install flathub com.spotify.Client
# install slack
flatpak install flathub com.slack.Slack

# install docker
sh ./get-docker.sh
sudo gpasswd -a $USER docker

# install consolas font
sh ./install_consolas.sh

# git ssh
touch ~/.ssh/config
echo 'Host *
    IPQoS=0x00' >> ~/.ssh/config

ssh-keygen

cd -

