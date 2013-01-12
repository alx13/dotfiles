_command_time_preexec() {
  timer=${timer:-$SECONDS}
  export ZSH_COMMAND_TIME=""
}

_command_time_precmd() {
  if [ $timer ]; then
    timer_show=$(($SECONDS - $timer))
    if [ -n "$TTY" ] && [ $timer_show -ge ${ZSH_COMMAND_TIME_MIN_SECONDS:-10} ]; then
      export ZSH_COMMAND_TIME="$timer_show"
    fi
    unset timer
  fi
}

zsh_command_time() {
  if [ -n "$ZSH_COMMAND_TIME" ]; then
    echo "(${ZSH_COMMAND_TIME}s)"
  fi
}

precmd_functions+=(_command_time_precmd)
preexec_functions+=(_command_time_preexec)
