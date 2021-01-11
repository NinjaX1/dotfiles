#!/usr/bin/env bash

# Themes https://github.com/robbyrussell/oh-my-zsh/wiki/Themes

ZSH="/usr/share/oh-my-zsh/"
ZSH_THEME="robbyrussell"
HIST_STAMPS="dd/mm/yyyy"
plugins=(git)

ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

source $ZSH/oh-my-zsh.sh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export BROWSER="/usr/bin/google-chrome-beta"
export EDITOR="nano"
export LS_COLORS="$LS_COLORS:ow=1;34:tw=1;34:"
export TERM="xterm-256color"

# sudo easy
alias chmod="sudo chmod"
alias mv="sudo mv"
alias pacman="sudo pacman"
alias pkill="sudo pkill"
alias rm="sudo rm"
alias systemctl="sudo systemctl"
alias sed="sudo sed"

# paths
alias hub="cd $HOME/GitHub && clear && ls -1"
alias aospk="cd $HOME/AOSPK"
alias x="cd /home/rom/AOSPK"

source $HOME/.functions/aospk.sh
source $HOME/.functions/git.sh
source $HOME/.functions/personal.sh

function dot() {
  pwd=$(pwd)
  cd $HOME
  rm -rf .dotfiles && git clone ssh://git@github.com/mamutal91/dotfiles .dotfiles
  source .zshrc
  cd $pwd
}

function bot() {
  pwd=$(pwd)
  cd $HOME
  echo "buildbot cloned."
  sudo rm -rf /home/buildbot $HOME/buildbot && git clone https://github.com/mamutal91/buildbot && sudo mv buildbot /home/
  cd $pwd
}
