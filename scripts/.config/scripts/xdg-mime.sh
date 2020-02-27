#!/bin/bash
# github.com/mamutal91

# Query filetype:
# Para descobrir o formato do arquivo
# xdg-mime query filetype file.txt
# xdg-mime query default video/mp4

# Web
xdg-mime default google-chrome-stable.desktop 'x-scheme-handler/about'
xdg-mime default google-chrome-stable.desktop 'x-scheme-handler/htm'
xdg-mime default google-chrome-stable.desktop 'x-scheme-handler/html'
xdg-mime default google-chrome-stable.desktop 'x-scheme-handler/http'
xdg-mime default google-chrome-stable.desktop 'x-scheme-handler/https'

# Images
xdg-mime default gpicview.desktop image/gif
xdg-mime default gpicview.desktop image/jpg
xdg-mime default gpicview.desktop image/jpeg
xdg-mime default gpicview.desktop image/png

# Videos
xdg-mime default smplayer.desktop video/x-matroska
xdg-mime default smplayer.desktop video/x-msvideo
xdg-mime default smplayer.desktop video/mp4

# Text
xdg-mime default atom.desktop text/plain

# Sheel Script
xdg-mime default atom.desktop text/x-shellscript
