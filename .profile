#!/bin/sh

# Start ssh-agent
eval `ssh-agent -s` > /dev/null

### Default programs ###
export EDITOR="nvim"
export READER="zathura"
export MANPAGER="sh -c 'col -bx | bat -l man --paging always -p'"
export TERMINAL="alacritty"
export BROWSER="firefox"
export VIDEO="mpv"
export IMAGE="sxiv"

### PATH exports ###
# $1 = path to export
try_export_path() {
  if [ -d "$1" ] ;
    then export PATH="$1:$PATH"
  fi
}

try_export_path $HOME/.scripts/bin

try_export_path $HOME/.bin

try_export_path $HOME/.local/bin

try_export_path $HOME/.yarn/bin

try_export_path $HOME/.cargo/bin

# Fzf options
export FZF_DEFAULT_OPTS="--reverse --cycle --margin 0,1"

# Android Studio
export JAVA_HOME=/usr/lib/jvm/default
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:~/android-studio/bin

# SPICETIFY (SPOTIFY)
export SPICETIFY_INSTALL="$HOME/spicetify-cli"
export PATH="$SPICETIFY_INSTALL:$PATH"

# Use custom mono path (C#)
export FrameworkPathOverride=/etc/mono/4.5

# Path for cuda
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/cuda/lib64

