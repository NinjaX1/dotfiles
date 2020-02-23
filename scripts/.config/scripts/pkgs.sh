#!/bin/bash
# github.com/mamutal91

# Mirrors
# sudo reflector -c Brazil --save /etc/pacman.d/mirrorlist
# sudo reflector -l 10 --sort rate --save /etc/pacman.d/mirrorlist

sudo pacman -Syyu

readonly PKGS_PACMAN=(
  alacritty alsa alsa-firmware alsa-utils android-tools archlinux-keyring atom
  bbswitch bluez bluez-libs bluez-tools bluez-utils bumblebee
  compton cronie
  dunst dhcpcd
  feh ffmpeg filezilla firefox firefox-i18n-pt-br
  galculator git gparted gpicview gvfs gvfs-mtp
  i3-gaps i3lock
  imagemagick
  jsoncpp
  lib32-libvdpau lib32-nvidia-utils lib32-opencl-nvidia lib32-virtualgl lxappearance
  maim mesa mpd mpv
  neofetch ntfs-3g
  numlockx nvidia nvidia-settings nvidia-utils
  opencl-nvidia openssh
  pinta pulseaudio pulseaudio-bluetooth pulseeffects python-setuptools
  qbittorrent qt5-connectivity
  reflector rofi
  sbc scrot smplayer steam stow
  telegram-desktop terminus-font thunar thunar-archive-plugin thunar-media-tags-plugin thunar-volman ttf-liberation
  unrar unzip
  wget winetricks wireless_tools
  xclip xf86-video-intel xorg-server xorg-xbacklight xorg-xinit xorg-xprop xorg-xrandr zsh)

readonly PKGS_AUR=(
  capitaine-cursors
  franz
  grive-git
  jre8-openjdk
  namebench nvidia-xrun
  polybar python-ruamel-yaml
  smplayer-skins smplayer-themes spotify
  ttf-dejavu ttf-font-awesome ttf-wps-fonts
  wps-office wps-office-extension-portuguese-brazilian-dictionary wps-office-mui-pt-br
  xidlehook
  zafiro-icon-theme zuki-themes zsh-syntax-highlighting-git)

function install-pkgs-pacman() {
  for i in "${PKGS_PACMAN[@]}"; do
    sudo pacman -S ${i} --needed --noconfirm
  done
}

function install-pkgs-aur() {
  for i in "${PKGS_AUR[@]}"; do
    yay -S ${i} --needed --noconfirm
  done
}

function install-yay() {
  git clone https://aur.archlinux.org/yay.git /home/mamutal91/yay
  cd "/home/mamutal91/yay"
  makepkg -si --noconfirm
  cd ..
  rm -rf yay
}

function winetricks() {
  winetricks --force directx9 vcrun2005 vcrun2008 vcrun2010 vcrun2012 vcrun2013 vcrun2015 dotnet40 dotnet452 vb6 xact xna31 xna40 msl31 openal corefonts
}

function oh-my-zsh() {
  rm -rf $HOME/.oh-my-zsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
}

function atom-packages() {
  # My favorites packages https://atom.io/packages/
  # Check the package name in the GitHub repository, in the file `package.json` for install
  pwd_atom_packages=$(pwd)
  rm -rf $HOME/.atom_tmp && mkdir $HOME/.atom_tmp && cd $HOME/.atom_tmp
  git clone https://github.com/abe33/atom-pigments
  git clone https://github.com/bhaskardabhi/atom-translator
  git clone https://github.com/denieler/save-workspace-atom-plugin
  git clone https://github.com/file-icons/atom
  git clone https://github.com/Glavin001/atom-beautify
  git clone https://github.com/h3imdall/ftp-remote-edit
  git clone https://github.com/taylon/language-i3wm
  apm install pigments atom-beautify atom-translator save-workspace file-icons ftp-remote-edit language-i3wm
  cd $pwd_atom_packages
}

function config-system() {
  USER=mamutal91
  git config --global user.email "mamutal91@gmail.com"
  git config --global user.name "Alexandre Rangel"
  sudo ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
  sudo systemctl enable dhcpcd
  sudo systemctl enable NetworkManager
  sudo systemctl enable cronie
  sudo systemctl enable bumblebeed.service
  sudo systemctl enable bluetooth
  sudo chown -R $USER:$USER /home/$USER
  sudo gpasswd -a $USER bumblebee
  chmod +x /home/$USER
}

# GPG keys import for SPOTIFY
gpg --keyserver hkps://keyserver.ubuntu.com --recv-keys 931FF8E79F0876134EDDBDCCA87FF9DF48BF1C90
gpg --keyserver hkps://keyserver.ubuntu.com --recv-keys 2EBF997C15BDA244B6EBF5D84773BD5E130D1D45

#winetricks
install-pkgs-pacman
install-yay
install-pkgs-aur
atom-packages
config-system
oh-my-zsh
