locate_nvmrc() {
    locate -w .nvmrc | xargs -I'{}' realpath --relative-to=. '{}' | awk '/^(\.\.\/)*\.nvmrc$/ {print $0}' | sort | xargs -I'{}' realpath '{}'
}

export PATH="$HOME/.nvm/versions/node/$(/bin/cat $HOME/.nvm/alias/default)/bin:$PATH"
nvm() {
    . $HOME/.nvm/nvm.sh; nvm "$@"
}

DEFAULT=$(locate_nvmrc)
cd() {
    if builtin cd "$@" 2>/dev/null; then
        FOUND="$(locate_nvmrc)"
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
