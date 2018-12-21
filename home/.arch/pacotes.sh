#!/bin/bash
# github.com/mamutal91

MY_USER=mamutal91

readonly PACOTES=(
    "firefox"
    "firefox-i18n-pt-br")

function aur_helper_yay(){
    sudo pacman -S git --needed --noconfirm
    git clone https://aur.archlinux.org/yay.git /home/${MY_USER}/yay
    cd "/home/${MY_USER}/yay"
    makepkg -si --noconfirm
    cd ..
    rm -rf yay
}

function zsh(){
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
}

function instalar_pacotes_pacman(){
    for i in "${PACOTES[@]}"; do
        sudo pacman -S ${i} --needed --noconfirm
    done 
}

function instalar_pacotes_aur(){
    for i in "${PACOTES[@]}"; do
        yay -S ${i} --needed --noconfirm
    done 
}

function configurar_sistema(){
    sudo systemctl enable NetworkManager
    sudo systemctl enable cronie
    sudo chown -R $MY_USER:$MY_USER /home/$MY_USER
}

echo :::::::::::::::::::::::: YAY - ZSH
#aur_helper_yay
zsh

echo :::::::::::::::::::::::: PACMAN
instalar_pacotes_pacman

echo :::::::::::::::::::::::: AUR
instalar_pacotes_aur

echo :::::::::::::::::::::::: Configurando sistema
configurar_sistema