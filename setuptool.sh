#!/bin/bash

echo "Do not run this script twice."
if [ $USER == "root" ]; then
  echo "!!Error: Do not run from root user."
fi
echo "Do you want to install softwares? If not, only the configs will be copied to your machine. [y/N]:"
read -n1 software

#install packages


case "$software" in
  [yY]* )
    echo "Do you want to install desktop environment? [y/N]:"
    read -n1 desktop
    sudo pacman -Syu
    case "$desktop" in
      [yY]* )
        #create i3wm desktop environment
        sudo pacman -S --noconfirm --needed xf86-video-intel #video driver for intel iGPU
        sudo pacman -S --noconfirm --needed xorg-server xorg-xinit xorg-xbacklight #X11 server
        sudo pacman -S --noconfirm --needed i3-wm lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings terminator #i3wm window manager, lightdm login interface, terminator terminal emulator
        sudo pacman -S --noconfirm --needed bluez bluez-utils pulseaudio-bluetooth #bluetooth utils for GUI
        sudo pacman -S --noconfirm --needed pulseaudio pavucontrol #audio utils
        sudo pacman -S --noconfirm --needed xrandr #for multiple monitor
        sudo pacman -S --noconfirm --needed firefox thunar feh maim xclip
        #make thunar show internal storages which aren't mounted yet
        sudo pacman -S --noconfirm --needed gvfs
        sudo pacman -S --noconfirm --needed rofi ttf-cica polybar #rofi program luncher, cica-font, polybar
  esac
  sudo pacman -S --noconfirm --needed atool neovim python3 curl fish cica #feh image viewer, atool compressing tool, fish shell, cica font
  sudo pacman -S --noconfirm --needed base-devel git gnupg wget unzip
  sudo systemctl enable lightdm
  sudo systemctl disable dhcpd #disable dhcpd for avoiding conflicts between NetworkManager and dhcpd

  #install aurman, an AUR helper tool, if it is not installed
  test -n $(cat /etc/pacman.conf| grep archlinuxfr)
  if [ $? = 1 ]; then
    git clone https://aur.archlinux.org/aurman.git
    cd aurman
    gpg --recv-keys `cat ./PKGBUILD | grep validpgpkey | sed "s/'/ /g" | awk '{print $2}'`
    makepkg -si
    cd ..
    rm -rf aurman
    sudo bash -c "echo -e '[archlinuxfr]\nSigLevel = Never\nServer =https://repo.archlinux.fr/\$arch' >> /etc/pacman.conf"
  fi
  aurman -Syu
  sudo systemctl enable lightdm
  sudo systemctl disable dhcpd #disable dhcpd for avoiding conflicts between NetworkManager and dhcpd

  #install dein and its requirements
  curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh | sh
  sh ./installer.sh ~/.cache/dein > /dev/null
  sudo pacman -S --noconfirm --needed nodejs yarn python-pip
  pip install neovim pynvim
  #SystemVerilog language server and XeTex compiler
  sudo pacman -S --noconfirm --needed cargo
  cargo install svls tectonic
esac

#settings

#make symbolic link to .config/(some package)
for file in $(find $(pwd -P)/$(dirname $0)/config -maxdepth 1 -type d); do
  if [ $(basename $file) == "config" ]; then
    continue
  fi
  echo $(dirname $0)
  echo $(pwd -P)/$(dirname $0)/config/$(basename $file)
  ln -s $(pwd -P)/$(dirname $0)/config/$(basename $file) ~/.config/$(basename $file)
done

echo "Please execute nvim for installing coc."
