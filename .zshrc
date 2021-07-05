#     ____ ____  _____         _          
#    / ___|  _ \|  ___| __ ___(_)_ __ ___ 
#   | |  _| |_) | |_ | '__/ _ \ | '__/ _ \     Guilherme Rugai Freire
#   | |_| |  _ <|  _|| | |  __/ | | |  __/     https://grfreire.com
#    \____|_| \_\_|  |_|  \___|_|_|  \___|     https://github.com/GRFreire
#                                         


# Themes
ZSH_THEME="robbyrussell"

# Oh my zsh
export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

### zinit plugins - start
source $HOME/.zinit/bin/zinit.zsh

zinit light zdharma/fast-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
### zinit plugins - end

# $1 = path to export
try_export_path() {
  if [ -d "$1" ] ;
    then export PATH="$1:$PATH"
  fi
}

try_export_path $HOME/.bin

try_export_path $HOME/.local/bin

try_export_path $HOME/.yarn/bin

try_export_path $HOME/.cargo/bin

# Alias config to manage dotfiles with git
alias config="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

# Alias for python3
alias python="python3"
alias pip="pip3"

# Alias to bat instead of cat
alias cat="bat --paging=never --style=header,grid"

# Alias to exa instead of ls
alias ls="exa --color=always --group-directories-first"

# Alias to nvim instead of vim
alias vim="nvim"

# This loads nvm
export PATH="$HOME/.nvm/versions/node/$(/bin/cat $HOME/.nvm/alias/default)/bin:$PATH"
nvm() {
  source $HOME/.nvm/nvm.sh; nvm "$@"
}

# Android Studio
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64
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

# Run color-scripts https://github.com/GRFreire/shell-color-scripts
colorscript random
