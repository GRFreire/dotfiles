#!/bin/sh

# Start polkit agent
lxpolkit &

# Enable numlock
/usr/bin/numlockx

# Start compositor
(sleep 1 && picom --experimental-backends) &

# Start notification server
dunst &

# Display background image
feh --bg-scale --no-fehbg ~/.config/wall.png

# Start conky
conky &

# Start X settings deamon
xsettingsd -c ~/.config/xsettingsd/xsettingsd.conf &

# Start network manager applet (systray)
nm-applet &

# Start bluetooth manager applet (systray)
blueman-applet &

# Start volume bar
~/.config/xob/volume.sh &

# Set up wacom tablet
autoxsetwacom

# Run hotkey deamon
sxhkd &

# Run xidlehook
xidlehook \
  `# Don't lock when there's a fullscreen application` \
  --not-when-fullscreen \
  `# Don't lock when there's audio playing` \
  --not-when-audio \
  `# Lock after 5 minutes` \
  --timer 300 \
    'betterlockscreen -l dimblur' \
    '' \
  `# Finally, suspend an hour after it locks` \
  --timer 3600 \
    'systemctl suspend' \
    '' &


# Run all applications in the autostart folder
dex ~/.config/autostart/*
