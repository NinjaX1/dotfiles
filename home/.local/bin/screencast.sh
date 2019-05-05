#!/bin/bash
# github.com/mamutal91

app=audience.png
appfim=XMind.png
icon=$iconsnotify/$app
iconfim=$iconsnotify/$appfim

variable=${1}

local=/home/mamutal91/Vídeos
file=$local/$(date "+%d-%m-%Y_%H-%M-%S")

[ ! -d $local ] && mkdir -p $local

function record(){
	DISPLAY=:0 dbus-launch -i $icon "Gravação de tela" "Início."
	canberra-gtk-play --file=$HOME/.local/share/sounds/screencast-start.wav
	ffmpeg -f x11grab -video_size 1920x1080 -i $DISPLAY -f alsa -i default -c:v ffvhuff -c:a flac $file.mkv
}

function stop(){
	DISPLAY=:0 dbus-launch -i $iconfim "Gravação de tela" "Fim."
	sudo pkill ffmpeg
	canberra-gtk-play --file=$HOME/.local/share/sounds/screencast-stop.wav
}

[[ $variable == "-start" ]] && record || stop
