#!/bin/bash
# github.com/mamutal91
# https://www.youtube.com/channel/UCbTjvrgkddVv4iwC9P2jZFw

# Git
git config --global user.email "mamutal91@gmail.com"
git config --global user.name "Alexandre Rangel"

sudo pacman -Syyu --noconfirm

# Install YAY AUR Manager
git clone https://aur.archlinux.org/yay.git $HOME/yay && cd "$HOME/yay" && makepkg -si --noconfirm && rm -rf $HOME/yay

# Load packages
source $HOME/.dotfiles/odyssey/.config/setup/packages.sh

# Install my packages
for i in "${PACKAGES[@]}"; do
  sudo pacman -S ${i} --needed --noconfirm
done

# Spotify
gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 931FF8E79F0876134EDDBDCCA87FF9DF48BF1C90
gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 2EBF997C15BDA244B6EBF5D84773BD5E130D1D45

for i in "${AUR[@]}"; do
  yay -S ${i} --needed --noconfirm
done

# Enable systemd services
for SERVICES in \
    dhcpcd \
    NetworkManager \
    cronie \
    bumblebeed.service \
    bluetooth
do
    sudo systemctl enable $SERVICES
    sudo systemctl start $SERVICES
done

# Groups
for GROUPS in \
    bumblebeed
do
    sudo gpasswd -a mamutal91 $GROUPS
done

# Install oh-my-zsh
# rm -rf $HOME/.oh-my-zsh && sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
