#!/bin/bash
# github.com/mamutal91

echo "Initializing configurations..."
echo "stow's..."
echo "Removing actual .dotfiles and copying /media/storage/GitHub/dotfiles from /home/mamutal91/.dotfiles"

rm -rf ~/.dotfiles && cp -rf /media/storage/GitHub/dotfiles ~/.dotfiles
rm -rf ~/.zshrc
cd ~/.dotfiles

for STOW in \
    alacritty \
    compton \
    dunst \
    files \
    gpicview \
    home \
    i3 \
    neofetch \
    polybar \
    rofi \
    scripts \
    setup \
    smplayer
do
    stow $STOW
done

sudo stow bbswitch -t /etc

function systemd() {
  echo "systemd's..."
  sudo rm -rf /etc/systemd/logind.conf
  sudo cp -rf ~/.dotfiles/systemd/logind.conf /etc/systemd
  sudo rm -rf /etc/systemd/system/getty@tty1.service.d/override.conf
  sudo mkdir -p /etc/systemd/system/getty@tty1.service.d/
  sudo cp -rf ~/.dotfiles/systemd/override.conf /etc/systemd/system/getty@tty1.service.d/
}

function X11() {
    echo "X11..."
    sudo rm -rf /etc/X11/nvidia-xorg.conf.d
    sudo rm -rf /etc/X11/xorg.conf.d
    sudo cp -rf ~/.dotfiles/X11/* /etc/X11
}

function first_boot() {
  echo "Removing default configs..."
  cd /home/mamutal91/.config
  rm -rf alacritty compton dunst files gpicview i3 neofetch polybar rofi scripts smplayer
  cd /etc/X11 && sudo rm -rf *
  cd /home/mamutal91/
  rm -rf .crontab .nanorc .nvidia-xinitrc .Xresources .zlogin .zshrc
}

#first_boot
systemd
X11

canberra-gtk-play --file=~/.config/files/sounds/completed.wav
i3-msg restart
sleep 1s
~/.config/polybar/launch.sh
