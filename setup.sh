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

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git

git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

#source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

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


cat ~/.ssh/id_rsa.pub

# git config --global user.email ***
# git config --global user.name *** 

sudo pacman -S gnome

touch ~/.xinitrc

echo "export XDG_SESSION_TYPE=x11
export GDK_BACKEND=x11
exec gnome-session" >> ~/.xinitrc

gsettings set org.gnome.desktop.interface enable-animations false

gsettings set org.gnome.desktop.interface color-scheme prefer-dark 

# ssh -T git@github.com -vvv
# zsh
# source ~/.zshrc

