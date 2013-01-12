autoload up-line-or-beginning-search
autoload down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey "^R"      history-incremental-search-backward  # ctrl-r
bindkey "^[[A"    up-line-or-beginning-search          # up
bindkey "^[[B"    down-line-or-beginning-search        # down

