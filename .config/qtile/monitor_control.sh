#!/bin/sh

DEVICE="$(brightnessctl -l -c backlight g | head -n 2 | tail -n 1 | cut -d ' ' -f2 | sed "s/'//g")"

case $1 in
    # Brightness
    b_current)
        brightnessctl -d $DEVICE | grep Current | cut -d' ' -f4 | sed 's/(\(.*\))/\1/';;
    b_up )
        brightnessctl -d "$DEVICE" set 5%+;;
    b_down )
        brightnessctl -d "$DEVICE" set 5%-;;
    * )
        echo "Command not valid" ; exit 1;;
esac

exit 0;
