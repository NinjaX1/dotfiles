#!/bin/bash
# github.com/mamutal91

# Mirrors
# sudo reflector -c Brazil --save /etc/pacman.d/mirrorlist
# sudo reflector -l 10 --sort rate --save /etc/pacman.d/mirrorlist

(cat ~/.cache/wal/sequences &)

USUARIO=mamutal91

sudo pacman -Sy

readonly PKGS_PACMAN=(
  git
  i3-gaps i3lock compton dunst rofi mpd maim ffmpeg neofetch scrot lxappearance feh gpicview python-pywal python-setuptools openssh cronie plasma-browser-integration
  zsh zsh-syntax-highlighting
  alsa alsa-utils
  termite terminus-font
  telegram-desktop
  atom pinta mpv smplayer qbittorrent galculator
  libreoffice-fresh libreoffice-fresh-pt-br
  firefox firefox-i18n-pt-br filezilla
  thunar thunar-archive-plugin thunar-media-tags-plugin thunar-volman
  steam ttf-liberation
  winetricks
  nvidia nvidia-settings nvidia-utils lib32-virtualgl lib32-nvidia-utils opencl-nvidia lib32-libvdpau lib32-opencl-nvidia
  xf86-video-intel bumblebee mesa bbswitch
  xorg-server xorg-xrandr xorg-xbacklight xorg-xinit xorg-xprop xautolock xclip
  linux-headers android-tools wicd wicd-gtk wireless_tools numlockx gvfs ntp unrar unzip wget)

readonly PKGS_AUR=(
  nvidia-xrun
  alsaequal
  polybar jsoncpp
  gvfs-mtp selinux-python
  arc-gtk-theme paper-icon-theme-git capitaine-cursors
  ttf-dejavu ttf-font-awesome nerdfont
  rambox-bin spotify grive-git)

function install_pkgs_pacman(){
  for i in "${PKGS_PACMAN[@]}"; do
    sudo pacman -S ${i} --needed --noconfirm
  done
}

function install_pkgs_aur(){
  for i in "${PKGS_AUR[@]}"; do
    yay -S ${i} --needed --noconfirm
  done
}

function winetricks(){
  winetricks --force directx9 vcrun2005 vcrun2008 vcrun2010 vcrun2012 vcrun2013 vcrun2015 dotnet40 dotnet452 vb6 xact xna31 xna40 msl31 openal corefonts
}

function setup_system(){
  sudo systemctl enable NetworkManager
  sudo systemctl enable cronie
  sudo systemctl enable ntpd
  sudo systemctl enable bumblebeed.service
  sudo chown -R $USUARIO:$USUARIO /home/$USUARIO
  sudo gpasswd -a $USUARIO bumblebee
}

#winetricks

install_pkgs_pacman
install_pkgs_aur
setup_system
