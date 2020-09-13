# github.com/mamutal91

# Themes https://github.com/robbyrussell/oh-my-zsh/wiki/Themes

ZSH=/usr/share/oh-my-zsh/
ZSH_THEME="robbyrussell"
plugins=(git)

ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

source $ZSH/oh-my-zsh.sh

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export TERM="xterm-256color"
export EDITOR="nano"
export BROWSER="/usr/bin/google-chrome-stable"
export JAVA_HOME="/usr/lib/jvm/java-8-openjdk"

alias nano="sudo nano"
alias pacman="sudo pacman"
alias systemctl="sudo systemctl"
alias p="git cherry-pick ${1}"
alias rm="sudo rm"
alias pkill="sudo pkill"

# Functions for git
function push () {
  echo "*********************************"
  echo "*** pushing for branch ELEVEN ***"
  git push https://github.com/aosp-forking/${1} HEAD:refs/heads/eleven --force
}

function commitm () {
  git add . && git commit --author "Alexandre Rangel <mamutal91@gmail.com>" && git push -f
}

function commit () {
  git add . && git commit --author "${1}" && git push -f
}

function amend () {
  git add . && git commit --amend && git push -f
}

function blog () {
  cd /media/storage/GITHUB/mamutal91.github.io
  ./_scripts/sh/create_pages.sh
}

# gCloud
function ss () {
  cat ~/.ssh/gcloud.pub | ssh mamutal91@${1} "mkdir -p ~/.ssh && cat >> /media/storage/GitHub/dotfiles/home/.ssh/authorized_keys"
  ssh -i ~/.ssh/gcloud mamutal91@${1}
}
