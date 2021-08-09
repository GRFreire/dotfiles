#!/bin/sh

case $1 in
    # Control
    play )
        playerctl play-pause ;;
    stop )
        playerctl stop ;;
    next )
        playerctl next ;;
    prev )
        playerctl previous ;;
    
    # Volume
    vol_up )
        amixer -q sset Master 5%+;;
    vol_down )
        amixer -q sset Master 5%-;;
    vol_mute )
        amixer -q -D pulse sset Master toggle;;
    * )
        echo "Command not valid" ; exit 1;;
esac

exit 0;