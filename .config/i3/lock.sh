#!/usr/bin/env bash

icon=$HOME/Pictures/locks/rmlock.png
tmpbg='/tmp/screen.png'

(( $# )) && { icon=$1; }

scrot "$tmpbg"
convert "$tmpbg" -blur 0x5 -gamma 0.6 -fill black -colorize 50% "$tmpbg"
convert "$tmpbg" "$icon" -gravity center -composite -matte "$tmpbg"
i3lock -i "$tmpbg"
rm "$tmpbg"
