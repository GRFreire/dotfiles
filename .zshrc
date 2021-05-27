#     ____ ____  _____         _          
#    / ___|  _ \|  ___| __ ___(_)_ __ ___ 
#   | |  _| |_) | |_ | '__/ _ \ | '__/ _ \     Guilherme Rugai Freire
#   | |_| |  _ <|  _|| | |  __/ | | |  __/	   https://grfreire.com
#    \____|_| \_\_|  |_|  \___|_|_|  \___|     https://github.com/GRFreire
#                                         

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Plugins
plugins=(git)

# Themes
ZSH_THEME="robbyrussell"

source $ZSH/oh-my-zsh.sh

# Themes
ZSH_THEME="spaceship"

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

# Alias to batcat instead of cat
alias cat="batcat --paging=never --style=header,grid"

# Alias to exa instead of ls
alias ls="exa --color=always --group-directories-first"

# This loads nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

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

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk

### zinit settinng things up - start
zinit light zdharma/fast-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
fpath+=${ZDOTDIR:-~}/.zsh_functions

fpath+=${ZDOTDIR:-~}/.zsh_functions
### zinit settinng things up - end

# Run color-scripts
colorscript random
