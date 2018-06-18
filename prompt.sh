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

export GIT_PS1_SHOWCOLORHINTS="true"
#export GIT_PS1_SHOWUPSTREAM="auto verbose"# verbose  ## how does this comment work?
export PROMPT_COMMAND='timer_stop; __git_ps1 "${timer_show}" "\W (λ) "; timer_stop'
