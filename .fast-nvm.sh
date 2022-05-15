list_nvmrc_recursive() {
    DIR="$(realpath "$1")"
    /bin/ls "$DIR/.nvmrc" 2>/dev/null
    PARENT_DIR="/$(realpath "$DIR/.." --relative-to=/)"
    if [ "$DIR" != "/" ]; then list_nvmrc_recursive "$PARENT_DIR"; fi;
}

export PATH="$NVM_DIR/versions/node/$(/bin/cat $NVM_DIR/alias/default)/bin:$PATH"
nvm() {
    . $NVM_DIR/nvm.sh; nvm "$@"
}

DEFAULT=$(list_nvmrc_recursive .)
cd() {
    if builtin cd "$@" 2>/dev/null; then
        FOUND="$(list_nvmrc_recursive .)"
        if [ "$FOUND" != "" ] && [ "$DEFAULT" != "$FOUND" ]; then
            DEFAULT=$FOUND
            nvm use
        fi
    else
        if test -f "$@"; then echo "cd: not a directory: $*"
        elif test -d "$@"; then echo "cd: can not change to $*"
        else echo "cd: no such file or directory: $*"
        fi
        return 1
    fi
}
