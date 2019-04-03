#!/bin/bash
# github.com/mamutal91

# Add no crontab
# */5 * * * * sh -c "~/.local/bin/gitcron.sh" > /dev/null 2>&1

git config --global user.email "mamutal91@gmail.com"
git config --global user.name "Alexandre Rangel"

dir="/media/storage/GitHub/"
repos=('archlinux' 'buildroid' 'mamutal91.github.io' 'strojects')
remoto="mamut@mamut"

app=git.png
icon=$iconsnotify/$app

atualiza() {
	if [ -d $1 ]; then
		if [ ! -f $1/.noup ]; then
			cd $1
			status=$(git add . -n)
			if [ ! -z "$status" ]; then
			c=$(echo $(git add . -n | tr '\r\n' ' '))
			m="Autocommit Git-Cron: $c"
			DISPLAY=:0 notify-send -i $icon "Git-Cron Commits" "$(basename $1)"
			git add .
			git commit -m "$m" -s --author="Alexandre Rangel <mamutal91@gmail.com>" --date "$(date)"
			git push
			DISPLAY=:0 notify-send -i $icon "Git-Cron Push" "$(basename $1) atualizado."
			fi
		fi
	fi
}

if [ ! $1 ] || [ $1 == "-a" ]; then
	for r in "${repos[@]}";	do
		caminho="${dir}/${r}"
		atualiza "$caminho"
	done

	atualiza "${HOME}/github"
	[ "$1" == "-a" ] && ssh $remoto "/usr/local/scripts/git-http"
else
	caminho="$@"
	atualiza "$caminho"
fi
