# Add tab completion
 
if [ -x "$(command -v brew)" ]; then
    local compPath="$(brew --prefix)/share/zsh-completions"
    if [ -d "$compPath" ]; then
        fpath=($compPath $fpath)
    fi
fi
