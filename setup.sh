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

sudo pacman -S zsh

chsh -s /bin/zsh

git clone https://github.com/H-goto16/zshrc.git

cp zshrc/.zshrc ~/

git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

#source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

sudo pacman -S zsh-syntax-highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

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

# oh-my-posh

sudo wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
sudo chmod +x /usr/local/bin/oh-my-posh
mkdir ~/.poshthemes
wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/themes.zip -O ~/.poshthemes/themes.zip
unzip ~/.poshthemes/themes.zip -d ~/.poshthemes
chmod u+rw ~/.poshthemes/*.omp.*
rm ~/.poshthemes/themes.zip

git config --global user.email $gitEmail
git config --global user.name $gitName

echo "Select 7 14 27 28"

sudo pacman -S gnome

touch ~/.xinitrc

echo "export XDG_SESSION_TYPE=x11
export GDK_BACKEND=x11
exec gnome-session" >> ~/.xinitrc

sudo pacman -S fcitx5-im fcitx5-mozc

gsettings set org.gnome.desktop.interface enable-animations false

gsettings set org.gnome.desktop.interface color-scheme prefer-dark 

sudo cp ~/ArchLinuxSetUp/environment /etc/environment

cat ~/.ssh/id_rsa.pub

# ssh -T git@github.com -vvv
# zsh
# source ~/.zshrc

