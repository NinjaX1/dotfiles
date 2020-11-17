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

export LS_COLORS="$LS_COLORS:ow=1;34:tw=1;34:"
export TERM="xterm-256color"
export EDITOR="nano"
export BROWSER="/usr/bin/google-chrome-beta"
export JAVA_HOME="/usr/lib/jvm/java-8-openjdk"

alias nano="sudo nano"
alias pacman="sudo pacman"
alias systemctl="sudo systemctl"
alias p="git cherry-pick ${1}"
alias rm="sudo rm"
alias pkill="sudo pkill"

alias github="cd /media/storage/github && clear && ls -1"
alias aosp="cd /media/storage/PurityAndroid && clear && ls -1"

# Functions for git
function push () {
  echo "> Pushing for branch @PurityAndroid - *${2}*"
  git push ssh://git@github.com/PurityAndroid/${1} HEAD:refs/heads/${2} --force
}

function pushm () {
  echo "> Pushing for branch @mamutal91 - *${2}*"
  git push ssh://git@github.com/mamutal91/${1} HEAD:refs/heads/${2} --force
}

function clone () {
  echo "> Cloning @PurityAndroid/${1} - *${2}*"
  git clone ssh://git@github.com/PurityAndroid/${1} -b ${2}
}

function clonem () {
  echo "> Cloning @mamutal91/${1} - *${2}*"
  git clone ssh://git@github.com/mamutal91/${1} -b ${2}
}

function cm () {
  git add . && git commit --author "Alexandre Rangel <mamutal91@gmail.com>" && git push -f
}

function c () {
  git add . && git commit --author "${1}" && git push -f
}

function amend () {
  git add . && git commit --amend && git push -f
}

function blog () {
  ./_scripts/sh/create_pages.sh
}
