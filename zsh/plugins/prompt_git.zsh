autoload -U colors && colors # Enable colors
prompt_git () {
    local s="";
    local branchName="";
    local gitStatus="";

    # Check if the current directory is in a Git repository.
    if [ "$(git rev-parse --is-inside-work-tree &>/dev/null; echo "${?}")" "==" "0" ]; then

        # check if the current directory is in .git before running git checks
        if [[ "$(git rev-parse --is-inside-git-dir 2> /dev/null)" == 'false' ]]; then

            # Ensure the index is up to date.
            git update-index --really-refresh -q &>/dev/null;

            local gitDir="$(git rev-parse --git-dir 2> /dev/null)"

            local numBehind="$(git log --oneline ..@{u} 2> /dev/null | wc -l | tr -d ' ')"
            local numAhead="$(git log --oneline @{u}.. 2> /dev/null | wc -l | tr -d ' ')"

            if [ "${numBehind}" -gt 0 ]; then
                s+="%{$reset_color%}"
                s+="%{$fg_bold[cyan]%}"
                s+="↓${numBehind}";
                s+="%{$reset_color%}"
            fi;

            if [ "${numAhead}" -gt 0 ]; then
                s+="%{$reset_color%}"
                s+="%{$fg_bold[magenta]%}"
                s+="↑${numAhead}";
                s+="%{$reset_color%}"
            fi;


            # Check for stashed files.
            if $(git rev-parse --verify refs/stash &>/dev/null); then
                s+="%{$reset_color%}"
                s+="%{$fg_bold[yellow]%}"
                s+="⚑";
                s+="%{$reset_color%}"
            fi;

            if [ -r "${gitDir}/MERGE_HEAD" ]; then
                s+="%{$reset_color%}"
                s+="%{$fg_bold[red]%}"
                s+="⚡︎";
                s+="%{$reset_color%}"
            fi;


            local gs=$(git status --porcelain 2> /dev/null)

            if [ -z "${gs}" ]; then
                s+="%{$reset_color%}"
                s+="%{$fg[green]%}"
                s+="✔";
                s+="%{$reset_color%}"
            fi;

            local numIndexAdded="$(echo "${gs}" | grep "^[MARC]" | wc -l | tr -d ' ')"
            local numIndexRemoved="$(echo "${gs}" | grep "^[D]" | wc -l | tr -d ' ')"
            local numTreeModified="$(echo "${gs}" | grep "^ [M]" | wc -l | tr -d ' ')"
            local numUntracked="$(echo "${gs}" | grep "^??" | wc -l | tr -d ' ')"

            if [ "${numIndexAdded}" -gt 0 ]; then
                s+="%{$reset_color%}"
                s+="%{$fg_bold[magenta]%}"
                s+="✚${numIndexAdded}";
                s+="%{$reset_color%}"
            fi;

            if [ "${numIndexRemoved}" -gt 0 ]; then
                s+="%{$reset_color%}"
                s+="%{$fg[yellow]%}"
                s+="✘${numIndexRemoved}";
                s+="%{$reset_color%}"
            fi;

            if [ "${numTreeModified}" -gt 0 ]; then
                s+="%{$reset_color%}"
                s+="%{$fg_bold[blue]%}"
                s+="●${numTreeModified}"
                s+="%{$reset_color%}"
            fi

            if [ "${numUntracked}" -gt 0 ]; then
                s+="%{$reset_color%}"
                s+="%{$fg_bold[white]%}"
                s+="…${numUntracked}"
                s+="%{$reset_color%}"
            fi
        fi;

        # Get the short symbolic ref.
        # If HEAD isn’t a symbolic ref, get the short SHA for the latest commit
        # Otherwise, just give up.
        branchName="$(git symbolic-ref --quiet --short HEAD 2> /dev/null || \
            git rev-parse --short HEAD 2> /dev/null || \
            echo '(unknown)')";



        gitStatus+="%{$reset_color%}"
        gitStatus+="%{$fg[green]%}"
        gitStatus+="["
        gitStatus+="%{$reset_color%}"

        gitStatus+="%{$reset_color%}"
        gitStatus+="%{$fg_bold[magenta]%}"
        gitStatus+="${branchName}"
        gitStatus+="%{$reset_color%}"

        if [ -n "${s}" ]; then
            gitStatus+="%{$reset_color%}"
            gitStatus+="|"
            gitStatus+="%{$reset_color%}"
                gitStatus+="${s}"
            gitStatus+="%{$reset_color%}"
        fi

        gitStatus+="%{$reset_color%}"
        gitStatus+="%{$fg[green]%}"
        gitStatus+="]"
        gitStatus+="%{$reset_color%}"

        echo -e "$gitStatus";
    else
        return;
    fi;
}
