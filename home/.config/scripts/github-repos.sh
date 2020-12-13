#!/usr/bin/env bash
# github.com/mamutal91

rm -rf /media/storage/GitHub && mkdir -p /media/storage/GitHub

for github in \
    android \
    archlinux-installer \
    mamutal91 \
    mamutal91.github.io \
    manual-custom-rom \
    iWantToSpeak \
    zsh-history \
    device_xiaomi_beryllium \
    device_xiaomi_sdm845-common
do
    git clone ssh://git@github.com/mamutal91/$github /media/storage/GitHub/$github
done

mv /media/storage/GitHub/mamutal91 /media/storage/GitHub/readme

# AOSPK manifest
mkdir -p /media/storage/AOSPK
rm -rf /media/storage/AOSPK/manifest && git clone ssh://git@github.com/AOSPK/manifest /media/storage/AOSPK/manifest
rm -rf /media/storage/AOSPK/aospk.com && git clone ssh://git@github.com/AOSPK/www /media/storage/AOSPK/aospk.com
