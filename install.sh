#!/usr/bin/env bash
# github.com/mamutal91

function boot() {
  cd $HOME/.config
  rm -rf alacritty dunst files gpicview i3 neofetch polybar picom rofi scripts
  cd /etc/X11 && sudo rm -rf *
}

# Uncomment only if first boot
#boot

pwd_dell_files=$(pwd)
cd $HOME
  rm -rf .bashrc .xinitrc .Xresources .zlogin .zshrc
cd $pwd_dell_files

cd $HOME/.dotfiles
stow alacritty
stow dunst
stow gpicview
stow home
stow i3
stow neofetch
stow picom
stow polybar
stow rofi

# Remove files from the system, and copy mine!
source $HOME/.dotfiles/setup/etc.sh

canberra-gtk-play --file=$HOME/.config/files/sounds/completed.wav
i3-msg restart
sleep 1
$HOME/.config/scripts/polybar-launch.sh
