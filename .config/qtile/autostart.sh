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

