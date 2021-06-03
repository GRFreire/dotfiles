#!/usr/bin/env bash

# Enable numlock
/usr/bin/numlockx

# Start compositor
picom --experimental-backends &

# Display background image
nitrogen --restore

# Start network manager applet (systray)
nm-applet &
