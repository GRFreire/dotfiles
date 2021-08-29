#!/bin/sh

# Start polkit agent
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# Enable numlock
/usr/bin/numlockx

# Start compositor
(sleep 1 && picom --experimental-backends) &

# Start notification server
dunst &

# Start clipboard manager
greenclip daemon &

# Display background image
feh --bg-scale ~/.config/wall.png

# Start conky
conky &

# Start network manager applet (systray)
nm-applet &

# Start volume bar
~/.config/xob/volume.sh &

