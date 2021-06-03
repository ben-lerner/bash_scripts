# time each command

function echo_right {
    # COLUMNS doesn't quite work in emacs shell
    printf "%$((${COLUMNS}-4))s\n" "$1"
}

function timer_start {
    START_TIME=$(date "+%s")
}

function timer_print {
    if [ -z $START_TIME ]; then  # first prompt
       return 0
    fi
    runtime=$(($(date "+%s") - $START_TIME))
    if [ "$runtime" -eq 0 ]; then
        runtime=""
    elif [ "$runtime" -lt "60" ]; then
        runtime=$runtime$"s"
    elif [ "$runtime" -lt "570" ]; then
        runtime=$(($runtime / 60))"m "$(($runtime % 60))"s"
    elif [ "$runtime" -lt "3570" ]; then
        runtime=$(($runtime + 30)) # round
        runtime=$(($runtime / 60))"m"
    else
        runtime=$(($runtime + 30)) # round
        runtime=$(($runtime / 3600))"h "$(( ($runtime % 3600) / 60 ))"m"
    fi

    if [ "$runtime" != "" ]; then
        echo_right "Ran in $runtime"
    fi
}

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

preexec() { timer_start; }
precmd() { timer_print; __git_ps1 "" "\W (λ) "; vterm_prompt_end; }
