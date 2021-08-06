#!/bin/sh

# Start polkit agent
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# Enable numlock
/usr/bin/numlockx

# Start compositor
picom --experimental-backends &

# Start notification server
dunst &

# Start clipboard manager
greenclip daemon &

# Display background image
nitrogen --restore

# Start network manager applet (systray)
nm-applet &

# Start volume bar
~/.config/xob/volume.sh &

