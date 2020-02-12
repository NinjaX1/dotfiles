#!/bin/bash
# github.com/mamutal91

app=git.png
icon=$iconsnotify/$app

dotfiles() {
	if [ -d $1 ]; then
		if [ ! -f $1/.noup ]; then
			cd /media/storage/GitHub/dotfiles
			status=$(git add . -n)
			if [ ! -z "$status" ]; then
			git add .
			git commit --author "Alexandre Rangel <mamutal91@gmail.com>" --date "$(date '+%Y-%m-%d %H:%M:%S')"
			git push
			DISPLAY=:0 dbus-launch notify-send -i $icon "git commit" "dotfiles atualizado."
			fi
		fi
	fi
}

dotfiles
