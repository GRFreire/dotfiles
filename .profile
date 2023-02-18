#!/bin/sh

### SET PATHS ###

# XDG Defaults
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

# Other applications
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export DVDCSS_CACHE="$XDG_DATA_HOME"/dvdcss
export MYPY_CACHE_DIR="$XDG_CACHE_HOME"/mypy
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node_repl_history
export NUGET_PACKAGES="$XDG_CACHE_HOME"/NuGetPackages
export NVM_DIR="$XDG_DATA_HOME"/nvm
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export SQLITE_HISTORY="$XDG_DATA_HOME"/sqlite_history
export ZDOTDIR="$HOME"/.config/zsh

### Start ssh-agent ###
eval `ssh-agent -s` > /dev/null

### Default programs ###
export EDITOR="nvim"
export READER="zathura"
export MANPAGER="sh -c 'col -bx | bat -l man --paging always -p'"
export TERMINAL="alacritty"
export BROWSER="firefox"
export VIDEO="mpv"
export IMAGE="nsxiv"

### PATH exports ###
# $1 = path to export
try_export_path() {
  if [ -d "$1" ] ;
    then export PATH="$1:$PATH"
  fi
}

try_export_path "$HOME/.scripts/bin"

try_export_path "$HOME/.bin"

try_export_path "$HOME/.opt/bin"

try_export_path "$HOME/.local/bin"

try_export_path "$HOME/.yarn/bin"

try_export_path "$CARGO_HOME/bin"

# Fzf options
export FZF_DEFAULT_OPTS="--reverse --cycle --margin 0,1"

export GOPATH="$HOME/.go"
export GOPATH="$GOPATH:$HOME/Projects/thirdparty/go"
export GOPATH="$GOPATH:$HOME/Projects/go"

# Use custom mono path (C#)
export FrameworkPathOverride=/etc/mono/4.5

# Path for cuda
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/lib/cuda/lib64"

