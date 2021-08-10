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

### zinit plugins - start
source $HOME/.zinit/bin/zinit.zsh

zinit light zdharma/fast-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
### zinit plugins - end

# Alias config to manage dotfiles with git
alias config="git --git-dir=\$HOME/.dotfiles/ --work-tree=\$HOME"

# Alias for python3
alias python="python3"
alias pip="pip3"

# Alias to bat instead of cat
alias cat="bat --paging=never --style=header,grid"

# Alias to exa instead of ls
alias ls="exa --color=always --group-directories-first"

# Alias to nvim instead of vim
alias vim="nvim"

# Fix zathura window swallowing
alias zathura="devour zathura"

# Allow zsh to "folow" ranger
alias ranger="source ranger"

# This loads nvm
export PATH="$HOME/.nvm/versions/node/$(/bin/cat $HOME/.nvm/alias/default)/bin:$PATH"
nvm() {
  source $HOME/.nvm/nvm.sh; nvm "$@"
}

# Run color-scripts https://github.com/GRFreire/shell-color-scripts
colorscript random
