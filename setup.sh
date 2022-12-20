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

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

zsh

source ~/.zshrc

yay -S nvm

nvm install stable

yay -S yarn

yay -S consolas-font

cd ~/.ssh

ssh-keygen -t rsa

touch ~/.ssh/config

echo "Host *
    IPQoS=0x00" >> ~/.ssh/config


cat ~/.ssh/id_rsa.pub

# ssh -T git@github.com -vvv

