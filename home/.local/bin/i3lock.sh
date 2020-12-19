#!/usr/bin/env bash
# github.com/mamutal91

scr='/tmp/screenshot.png'
icon="$HOME/.local/share/i3lock/i3lock.png"

[ ! -d $HOME/.local/share/i3lock/ ] && mkdir -p $HOME/.local/share/i3lock/

gradientColor='#282a36'

# Screenshot para plano de fundo do i3lock
maim "$scr"

# Obtenha dimensões gradientes diretamente da captura de tela
read width height <<<$(file $scr | cut -d, -f 2 | tr -d ' ' | tr 'x' ' ')
height=$((height / 2))

convert "$scr" -scale 10% -scale 1000%\
	-size "${width}x${height}" -gravity south-west \
	gradient:none-"$gradientColor" -composite -matte \
	"$icon" -gravity center -composite -matte \
	-gravity center -pointsize 20 \
	-font $font -fill "#EAE4D1" -annotate +0+200 "$fortune" "$scr"
i3lock -ui "$scr"
