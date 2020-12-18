#!/usr/bin/env bash

# Colors
END=$(tput sgr0)                    #  reset flag
BLA=$END$(tput setaf 0)             #  black
RED=$END$(tput setaf 1)             #  red
GRE=$END$(tput setaf 2)             #  green
YEL=$END$(tput setaf 3)             #  yellow
BLU=$END$(tput setaf 4)             #  blue
MAG=$END$(tput setaf 5)             #  magenta
CYA=$END$(tput setaf 6)             #  cyan
WHI=$END$(tput setaf 7)             #  white
BOL=$(tput bold)                    ## bold flag
BOL_BLA=$END$BOL$(tput setaf 0)     #  black
BOL_RED=$END$BOL$(tput setaf 1)     #  red
BOL_GRE=$END$BOL$(tput setaf 2)     #  green
BOL_YEL=$END$BOL$(tput setaf 3)     #  yellow
BOL_BLU=$END$BOL$(tput setaf 4)     #  blue
BOL_MAG=$END$BOL$(tput setaf 5)     #  magenta
BOL_CYA=$END$BOL$(tput setaf 6)     #  cyan
BOL_WHI=$END$BOL$(tput setaf 7)     #  white

function p () {
  git cherry-pick ${1}
}

if [ $HOST = "aspire" ]; then
  function cm () {
    git add . && git commit --author "Alexandre Rangel <mamutal91@gmail.com>" && git push -f
  }
  function c () {
    git add . && git commit --author "${1}" && git push -f
  }
  function amend () {
    git add . && git commit --amend && git push -f
  }
else
  function cm () {
    git add . && git commit --author "Alexandre Rangel <mamutal91@gmail.com>"
  }
  function c () {
    git add . && git commit --author "${1}"
  }
  function amend () {
    git add . && git commit --amend
  }
fi

# Tree for beryllium
function tree () {
  rm -rf device/xiaomi/beryllium device/xiaomi/sdm845-common hardware/xiaomi
  git clone ssh://git@github.com/mamutal91/device_xiaomi_beryllium -b eleven device/xiaomi/beryllium
  git clone ssh://git@github.com/mamutal91/device_xiaomi_sdm845-common -b eleven device/xiaomi/sdm845-common
  git clone https://github.com/LineageOS/android_hardware_xiaomi -b lineage-18.1 hardware/xiaomi
}

function kernel () {
  rm -rf kernel/xiaomi
  git clone ssh://git@github.com/mamutal91/kernel_xiaomi_sdm845 -b eleven kernel/xiaomi/sdm845
}

function vendor () {
  rm -rf vendor/xiaomi
  git clone ssh://git@github.com/mamutal91/vendor_xiaomi -b eleven vendor/xiaomi
}

# Functions for git
function push () {
  if [ "${3}" = true ];
  then
    FORCE="&& git push -f"
  fi
  echo "${BOL_GRE}Pushing github.com/AOSPK/${1} - ${2}${END}"
  git push ssh://git@github.com/AOSPK/${1} HEAD:refs/heads/${2} ${3}
}

function clone () {
  echo "${BOL_BLU}Cloning github.com/AOSPK/${1} - ${2}${END}"
  git clone ssh://git@github.com/AOSPK/${1} -b ${2}
}

function los () {
  echo "Cloning github.com/LineageOS/android_${1} - ${2}"
  rm -rf ${1} && git clone https://github.com/LineageOS/android_${1} -b ${2} ${1} && cd ${1}
}

function up () {
  upstream ${1} lineage-18.1 eleven
  upstream ${1} lineage-17.1 ten
  upstream ${1} lineage-16.0 pie
  upstream ${1} lineage-15.1 oreo-mr1
  upstream ${1} cm-14.1 nougat
}

upstream () {
  cd $HOME && rm -rf ${1}
  echo "${BOL_CYA}Cloning LineageOS/android_${1} -b ${2}${END}"
  git clone https://github.com/LineageOS/android_${1} -b ${2} ${1}
  cd ${1} && push ${1} ${3}
  rm -rf $HOME/${1}
}

function hals () {
  /home/buildbot/scripts/hal/hal.sh apq8084
  home/buildbot/scripts/hal/hal.sh msm8960
  home/buildbot/scripts/hal/hal.sh msm8916
  home/buildbot/scripts/hal/hal.sh msm8974
  home/buildbot/scripts/hal/hal.sh msm8996
  home/buildbot/scripts/hal/hal.sh msm8998
  home/buildbot/scripts/hal/hal.sh sdm845
  home/buildbot/scripts/hal/hal.sh sm8150
  home/buildbot/scripts/hal/hal.sh sm8250

  home/buildbot/scripts/hal/limp.sh pn5xx
  home/buildbot/scripts/hal/limp.sh sn100x
}

function www() {
  cd $HOME && rm -rf www
  git clone ssh://git@github.com/AOSPK/www
  sudo rm -rf /home/www
  sudo mv www ..
  cd /home/www
  sudo npm i && sudo npm run build
}
