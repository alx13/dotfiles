autoload -U colors && colors # Enable colors

local pFormat
pFormat+="%{$reset_color%}"
pFormat+="%{$fg[green]%}"
pFormat+="%n"
pFormat+="%{$reset_color%}"

pFormat+="@"

pFormat+="%{$reset_color%}"
pFormat+="%{$fg[green]%}"
pFormat+="%m"
pFormat+="%{$reset_color%}"

pFormat+=":"

pFormat+="%{$reset_color%}"
pFormat+="%{$fg_bold[yellow]%}"
pFormat+="%~"
pFormat+="%{$reset_color%}"

pFormat+=$'%{$(prompt_git)%}'

pFormat+=$'\n'
pFormat+=$'%{$(iterm2_prompt_mark)%}'
pFormat+=$'$ '

export PS1="${pFormat}"
export RPS1='$(zsh_command_time)%(?.. [%?])'

export SPROMPT='Correct $fg_bold[red]%R$reset_color to $fg[green]%r$reset_color [(y)es (n)o (a)bort (e)dit]? '
