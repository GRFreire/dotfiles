#!/bin/sh

CONFIG="styles.cfg"

([ "$1" = "-r" ] || [ "$1" = "--reload" ] && echo "$CONFIG" | entr -r "$0" "$2") || (.venv/bin/python "$WATCHER" | xob -s "$1")
