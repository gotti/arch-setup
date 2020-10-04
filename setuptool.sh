#!/bin/bash

echo "Do not run this script twice."
if [ $USER == "root" ]; then
  echo "!!Error: Do not run from root user."
fi
#create i3wm desktop environment
sudo pacman -Syu
sudo pacman -S --noconfirm --needed xf86-video-intel #video driver for intel iGPU
sudo pacman -S --noconfirm --needed xorg-server xorg-xinit xorg-xbacklight #X11 server
sudo pacman -S --noconfirm --needed i3-wm lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings terminator #i3wm window manager, lightdm login interface, terminator terminal emulator
sudo pacman -S --noconfirm --needed bluez bluez-utils pulseaudio-bluetooth #bluetooth utils for GUI
sudo pacman -S --noconfirm --needed pulseaudio pavucontrol #audio utils
sudo pacman -S --noconfirm --needed feh maim atool neovim python3 curl fish cica #feh image viewer, atool compressing tool, fish shell, cica font
sudo pacman -S --noconfirm --needed xrandr #for multiple monitor
sudo pacman -S --noconfirm --needed firefox thunar
sudo systemctl enable lightdm
sudo systemctl disable dhcpd #disable dhcpd for avoiding conflicts between NetworkManager and dhcpd

#important!! make thunar show internal storages
sudo pacman -S gvfs
sudo pacman -S --noconfirm --needed base-devel git gnupg wget unzip xclip
#install aurman, an AUR helper tool, if it is not installed
git clone https://aur.archlinux.org/aurman.git
test -n $(cat /etc/pacman.conf| grep archlinuxfr)
if [ $? = 0 ]; then
  cd aurman
  gpg --recv-keys `cat ./PKGBUILD | grep validpgpkey | sed "s/'/ /g" | awk '{print $2}'`
  makepkg -si
  cd ..
  rm -rf aurman
  sudo bash -c "echo -e '[archlinuxfr]\nSigLevel = Never\nServer =https://repo.archlinux.fr/\$arch' >> /etc/pacman.conf"
fi
aurman -Syu
pacman -S --noconfirm --needed rofi ttf-cica polybar #rofi program luncher, cica-font, polybar
#copy dotfiles
mkdir ~/.config/backup
mv ~/.config/* ~/.config/backup/
cp -rf $(dirname $0)/config/* ~/.config/
#copy other configs
##copy x11 config
sudo cp -rf ./otherconfig/X11/* /etc/X11/xorg.conf.d/
#install dein
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh ~/.cache/dein
sudo pacman -S --noconfirm --needed nodejs yarn python-pip
pip install neovim pynvim
