#     ____ ____  _____         _          
#    / ___|  _ \|  ___| __ ___(_)_ __ ___ 
#   | |  _| |_) | |_ | '__/ _ \ | '__/ _ \     Guilherme Rugai Freire
#   | |_| |  _ <|  _|| | |  __/ | | |  __/     https://grfreire.com
#    \____|_| \_\_|  |_|  \___|_|_|  \___|     https://github.com/GRFreire
#                                         

source ~/.profile

# Themes
ZSH_THEME="robbyrussell"

# Oh my zsh
export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

# Set cursor to beam shape
echo -ne '\e[5 q'

export HISTORY_IGNORE="ce"

### zinit plugins - start
source $HOME/.zinit/bin/zinit.zsh

zinit light zdharma/fast-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
### zinit plugins - end

# Fzf keybinds
# <CTRL+R> search history of shell commands
source /usr/share/fzf/key-bindings.zsh

# Alias config to manage dotfiles with git
alias config="git --git-dir=\$HOME/.dotfiles/ --work-tree=\$HOME"

# Pacman Search
alias pacs="pacman -Slq | fzf --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"
alias apacs="paru -Slq | fzf --multi --preview 'paru -Si {1}' | xargs -ro paru -S"

# Config/scripts Edit
alias ce="echo \"\$(/bin/ls \$HOME/.scripts/bin | sed \"s|^|\$(realpath \$HOME/.scripts/bin/ --relative-to=.)/|\")\n\$((cd \$HOME && config ls-tree -r master --name-only \$HOME) | sed \"s|^|\$(realpath \$HOME --relative-to=.)/|\" | sed 's|^\./||')\" | fzf --info=inline --prompt='Select a file: ' --preview='bat --paging=never --style=plain --color=always {}' | xargs -r \$EDITOR"
bindkey -s '^e' 'ce\n'

# Alias for python3
alias python="python3"
alias pip="pip3"

# Alias to bat instead of cat
alias cat="bat --paging=never --style=header,grid"

# Alias to exa instead of ls
alias ls="exa --color=always --icons --group-directories-first"

# Alias to exa instead of less
alias less="bat -p"

# Alias to nvim instead of vim
alias vim="nvim"

# Alias to plocate instead of locate
alias locate="plocate"

# Alias to sxiv with some flags
alias sxiv="sxiv -ad"

# Allow zsh to "folow" ranger
alias ranger="source ranger"
bindkey -s '^[^f' 'ranger\n'

# This loads nvm
source $HOME/.fast-nvm.sh
source $HOME/.nvm/bash_completion

# Check if is integrated terminal emulator
if [ -z "$INTEG_EMU" ]; then
  colorscript random;
fi
