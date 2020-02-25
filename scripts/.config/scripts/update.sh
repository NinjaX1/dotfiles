#!/bin/bash
# github.com/mamutal91

app=pacman.png
icon=$icons_path/$app

sleep 1

echo "Atualizando Pacman e AUR"
  sudo pacman -Syyu
  yay -Syyu

echo "Removendo pacotes não utilizados"
  sudo pacman -Qdtq --noconfirm
  yay -Qdtq --noconfirm
  sudo pacman -Rncs $(pacman -Qdtq) --noconfirm
  yay -Rncs $(yay -Qdtq) --noconfirm

canberra-gtk-play --file=~/.config/files/sounds/completed.wav
DISPLAY=:0 dbus-launch notify-send -i $icon "archlinux" "Pacotes atualizados com sucesso."
