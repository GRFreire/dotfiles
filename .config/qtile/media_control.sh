#!/bin/sh

control_play() {
    dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause
    mpc toggle
}

control_stop() {
    dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Stop
    mpc stop
}

control_next() {
    dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next
    mpc next
}

control_prev() {
    dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous
    mpc prev
}

case $1 in
    # Control
    play )
        control_play ;;
    stop )
        control_stop ;;
    next )
        control_next ;;
    prev )
        control_prev ;;
    
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