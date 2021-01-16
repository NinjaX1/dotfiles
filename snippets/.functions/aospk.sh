#!/usr/bin/env bash

function s() {
  repo init -u https://github.com/AOSPK/manifest -b eleven
  repo sync -c -j$(nproc --all) --no-clone-bundle --current-branch --no-tags --force-sync
}

function b() {
  export CUSTOM_BUILD_TYPE=OFFICIAL
  export CCACHE_EXEC=$(which ccache)
  export USE_CCACHE=1
  export CCACHE_DIR=/mnt/roms/.ccache
  ccache -M 200G
  . build/envsetup.sh && lunch aosp_beryllium-userdebug && make bacon -j$(nproc --all) | tee log.txt
}

function bp() {
  s && b
}

function down() {
  cd out/target/product/beryllium
  sudo cp -rf ${1} /mnt/mamutal91.me
  echo "https://mamutal91.me/${1}"
}

function gerrit() {
  xdg-open https://review.lineageos.org/q/project:LineageOS/android_${1}+status:merged+branch:lineage-18.1
}

function github() {
  xdg-open https://github.com/LineageOS/android_${1}/commits/lineage-18.1
  xdg-open https://github.com/AOSPK/${1}/commits/eleven
}

function tree() {
  rm -rf device/xiaomi/beryllium device/xiaomi/sdm845-common hardware/xiaomi
  git clone ssh://git@github.com/mamutal91/device_xiaomi_beryllium -b eleven device/xiaomi/beryllium
  git clone ssh://git@github.com/mamutal91/device_xiaomi_sdm845-common -b eleven device/xiaomi/sdm845-common
  git clone https://github.com/LineageOS/android_hardware_xiaomi -b lineage-18.1 hardware/xiaomi
}

function kernel() {
  rm -rf kernel/xiaomi/sdm845
  git clone ssh://git@github.com/mamutal91/kernel_xiaomi_sdm845 -b eleven kernel/xiaomi/sdm845
}

function vendor() {
  rm -rf vendor/xiaomi
  git clone ssh://git@github.com/mamutal91/vendor_xiaomi -b eleven vendor/xiaomi
}

function push() {
  if [[ "${3}" = true ]];
  then
    FORCE="&& git push -f"
  fi
  echo "${BOL_GRE}Pushing github.com/AOSPK/${1} - ${2}${END}"
  git push ssh://git@github.com/AOSPK/${1} HEAD:refs/heads/${2} ${3}
}

function clone() {
  echo "${BOL_BLU}Cloning github.com/AOSPK/${1} - ${2}${END}"
  git clone ssh://git@github.com/AOSPK/${1} -b ${2} && cd ${1}
}

function los() {
  echo "Cloning github.com/LineageOS/android_${1} - ${2}"
  rm -rf ${1} && git clone https://github.com/LineageOS/android_${1} -b ${2} ${1} && cd ${1}
}

upstream() {
  cd $HOME && rm -rf ${1}
  echo "${BOL_CYA}Cloning LineageOS/android_${1} -b ${2}${END}"
  git clone https://github.com/LineageOS/android_${1} -b ${2} ${1}
  cd ${1} && push ${1} ${3}
  rm -rf $HOME/${1}
}

function up() {
  upstream ${1} lineage-18.1 eleven
  upstream ${1} lineage-17.1 ten
  upstream ${1} lineage-16.0 pie
  upstream ${1} lineage-15.1 oreo-mr1
  upstream ${1} cm-14.1 nougat
}

function hals() {
  /mnt/roms/buildbot/scripts/hal/hal.sh apq8084
  /mnt/roms/buildbot/scripts/hal/hal.sh msm8960
  /mnt/roms/buildbot/scripts/hal/hal.sh msm8916
  /mnt/roms/buildbot/scripts/hal/hal.sh msm8974
  /mnt/roms/buildbot/scripts/hal/hal.sh msm8996
  /mnt/roms/buildbot/scripts/hal/hal.sh msm8998
  /mnt/roms/buildbot/scripts/hal/hal.sh sdm845
  /mnt/roms/buildbot/scripts/hal/hal.sh sm8150
  /mnt/roms/buildbot/scripts/hal/hal.sh sm8250

  /mnt/roms/buildbot/scripts/hal/limp.sh pn5xx
  /mnt/roms/buildbot/scripts/hal/limp.sh sn100x

  /mnt/roms/buildbot/scripts/hal/caf.sh
}

function www() {
  pwd=$(pwd)
  cd $HOME && rm -rf www
  git clone ssh://git@github.com/AOSPK/www
  sudo rm -rf /mnt/roms/www
  sudo mv www /mnt/roms
  cd /mnt/roms/www
  sudo npm i && sudo npm run build
  cd $pwd
}
