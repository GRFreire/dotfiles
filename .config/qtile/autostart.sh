#!/usr/bin/env bash

# Start polkit agent
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# Enable numlock
/usr/bin/numlockx

# Start compositor
picom --experimental-backends &

# Start notification server
dunst &

# Display background image
nitrogen --restore

# Start network manager applet (systray)
nm-applet &
