echo -n "Input git Name : "
read gitName
echo -n "Input git Email : "
read gitEmail

sudo pacman -Syu

sudo pacman -S --needed $(comm -12 <(pacman -Slq | sort) <(sort base.txt))

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

yay -S --needed $(comm -12 <(pacman -Slq | sort) <(sort app.txt))

mkdir ~/.ssh && cd $_

ssh-keygen -t rsa

touch ~/.ssh/config

echo "Host *
    IPQoS=0x00" >> ~/.ssh/config

git config --global user.email $gitEmail
git config --global user.name $gitName

sudo cp ~/ArchLinuxSetUp/fcitx/environment /etc/environment

cp /etc/X11/xinit/xserverrc ~/.xserverrc

cat ~/.ssh/id_rsa.pub

