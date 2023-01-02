#!/usr/bin/env bash

## Copyright (C) 2020-2022 Aditya Shakya <adi1090x@gmail.com>
## Everyone is permitted to copy and distribute copies of this file under GNU-GPL3
## Autostart Programs

# Kill already running process
_ps=(picom dunst ksuperkey mpd xfce-polkit xfce4-power-manager polybar blueman-applet)
for _prs in "${_ps[@]}"; do
	if [[ `pidof ${_prs}` ]]; then
		killall -9 ${_prs}
	fi
done

# Fix cursor
xsetroot -cursor_name left_ptr

# Polkit agent
/usr/lib/xfce-polkit/xfce-polkit &

# Enable power management
xfce4-power-manager &

# Enable Super Keys For Menu
ksuperkey -e 'Super_L=Alt_L|F1' &
ksuperkey -e 'Super_R=Alt_L|F1' &

# Restore wallpaper
# hsetroot -cover ~/.config/i3/wallpapers/default.png

# Launch notification daemon
#~/.config/i3/bin/i3dunst.sh

# Launch polybar
# ~/.config/i3/bin/i3bar.sh

# Launch compositor
#~/.config/i3/bin/i3comp.sh

# Restore Wallpaper
exec variety --resume &
#Start Polybar
exec polybar &
#Transparent
exec picom &
# Bluetooth Headphone Controls
exec mpris-proxy &

exec blueman-applet &

exec mpd &
