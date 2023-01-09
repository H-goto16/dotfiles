echo -n "Input git Name : "
read gitName
echo -n "Input git Email : "
read gitEmail

sudo pacman -Syu

sudo pacman -S git

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

yay -Syu

sudo pacman -S noto-fonts noto-fonts-cjk

yay -S google-chrome

yay -S visual-studio-code-bin

yay -S nvm

source /usr/share/nvm/init-nvm.sh

echo 'source /usr/share/nvm/init-nvm.sh' >> ~/.bashrc

nvm install 16.2.0

npm install --global yarn

yay -S consolas-font

mkdir ~/.ssh && cd $_

ssh-keygen -t rsa

touch ~/.ssh/config

echo "Host *
    IPQoS=0x00" >> ~/.ssh/config

git config --global user.email $gitEmail
git config --global user.name $gitName

sudo pacman -S fcitx5-im fcitx5-mozc

sudo cp ~/ArchLinuxSetUp/environment /etc/environment

cat ~/.ssh/id_rsa.pub
