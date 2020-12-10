# time each command

function timer_start {
    timer=${timer:-$SECONDS}
}

function timer_stop {
    timer_show=$(($SECONDS - $timer))
    if [ "$timer_show" -eq 0 ]; then
        timer_show=""
    elif [ "$timer_show" -lt "60" ]; then
        timer_show=$timer_show$"s"
    elif [ "$timer_show" -lt "570" ]; then
        timer_show=$(($timer_show / 60))"m "$(($timer_show % 60))"s"
    elif [ "$timer_show" -lt "3570" ]; then
        timer_show=$(($timer_show + 30)) # round
        timer_show=$(($timer_show / 60))"m"
    else
        timer_show=$(($timer_show + 30)) # round
        timer_show=$(($timer_show / 3600))"h "$(( ($timer_show % 3600) / 60 ))"m"
    fi

    if [ "$timer_show" != "" ]; then
        timer_show=$timer_show" :: "
    fi

    unset timer
}

trap 'timer_start' DEBUG

# git prompt
source "$DIR/git-prompt.sh"

# vterm directory tracking
vterm_printf(){
    if [ -n "$TMUX" ]; then
        # Tell tmux to pass the escape sequences through
        # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
        printf "\ePtmux;\e\e]%s\007\e\\" "$1"
    elif [ "${TERM%%-*}" = "screen" ]; then
        # GNU screen (screen, screen-256color, screen-256color-bce)
        printf "\eP\e]%s\007\e\\" "$1"
    else
        printf "\e]%s\e\\" "$1"
    fi
}

vterm_prompt_end(){
    vterm_printf "51;A$(whoami)@$(hostname):$(pwd)"
}


export GIT_PS1_SHOWCOLORHINTS="true"
#export GIT_PS1_SHOWUPSTREAM="auto verbose"# verbose  ## how does this comment work?
export PROMPT_COMMAND='timer_stop; __git_ps1 "${timer_show}" "\W (λ) "; timer_stop; vterm_prompt_end'
