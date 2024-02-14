source ~/.profile

# Themes
ZSH_THEME="robbyrussell"

# Oh my zsh
export ZSH="$HOME/.local/share/ohmyzsh"
source $ZSH/oh-my-zsh.sh

# Load cargo env
if [ -d "$CARGO_HOME" ]; then
    . "$CARGO_HOME/env"
fi

# Set cursor to beam shape
echo -ne '\e[5 q'

# ZSH Specific
compinit -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION

export HISTORY_IGNORE="ce"

### zinit plugins - start
ZINIT_PATH="$HOME/.local/share/zinit"
source $ZINIT_PATH/zinit.zsh

zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light djui/alias-tips
### zinit plugins - end

export ZSH_PLUGINS_ALIAS_TIPS_EXCLUDES="_"

# Fzf keybinds
# <CTRL+R> search history of shell commands
if [ $OS_RELEASE = "debian" ]; then
    source /usr/share/doc/fzf/examples/key-bindings.zsh
else
    source /usr/share/fzf/key-bindings.zsh
fi

# Alias config to manage dotfiles with git
alias config="git --git-dir=\$HOME/.dotfiles/ --work-tree=\$HOME"

# Pacman Search
alias pacs="pacman -Slq | fzf --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"
alias apacs="paru -Slq | fzf --multi --preview 'paru -Si {1}' | xargs -ro paru -S"

fzf_fast_file_edit() {
  # Get scripts
  scripts="$(/bin/ls "$HOME/.scripts/bin" | sed "s|^|$(realpath "$HOME"/.scripts/bin/ --relative-to=.)/|")"

  # Get config files
  current_branch="$(config rev-parse --abbrev-ref HEAD)"
  config_files="$(config ls-tree -r "$current_branch" --name-only "$HOME")"

  # Select file
  selected_file=$(printf "%s\n%s" "$scripts" "$config_files" | fzf --info=inline --prompt='Select a file: ' --preview="$bat_cmd --paging=never --style=plain --color=always {}")

  
  if [ -n "$selected_file" ]; then
    $EDITOR "$selected_file"
  fi
}
bindkey -s '^[^E' 'fzf_fast_file_edit\n'

# Alias for python3
alias python="python3"
alias pip="pip3"

# Alias to bat instead of cat
[ $OS_RELEASE = "debian" ] && bat_cmd="batcat" || bat_cmd="bat"
alias cat="$bat_cmd --paging=never --style=header,grid"

# Alias to exa instead of ls
alias ls="exa --color=always --icons --group-directories-first"
alias tree="ls --tree"

# Alias to bat instead of less
alias less="$bat_cmd -p --paging=always"

# Alias to nvim instead of vim
alias vim="nvim"

# Alias to plocate instead of locate
alias locate="plocate"

# Alias to nsxiv with some flags
alias nsxiv="nsxiv -a"

alias ssh="TERM=xterm-256color ssh"

# Alias to ip with some flags
alias ip="ip --color=always"

# Allow zsh to "folow" ranger
alias ranger="source ranger"
bindkey -s '^[^f' 'ranger\n'

# Alias btw to neofetch
alias btw="neofetch"

# Alias for qrcode
alias qrcode="qrencode -s 10 -l H"

# This loads fnm/nvm
if [ $(command -v fnm) ]; then
    eval "$(fnm env --use-on-cd)"
else
    source $HOME/.config/fast-nvm.sh
    source $NVM_DIR/bash_completion
fi

# Check if is integrated terminal emulator
if [ "$EMULATOR" = "code" ]; then
  export EDITOR="code --wait"
else
  colorscript random
fi
