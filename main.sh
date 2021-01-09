# set .bash_profile to:
# source ~/bash_scripts/main.sh


if [ "$SHELL" = "/bin/zsh" ]; then
    DIR=${0:a:h}
else
    DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
fi

source "${DIR}/vars.sh"
source "${DIR}/git-profile.sh"

# for emacs to source correctly
if [ ! -f ~/.bashrc ]; then
    echo "source ~/.bash_profile; cd" > ~/.bashrc
fi

# clojure
alias "deps-update"="clojure -Aoutdated --update"

# ripgrep
alias ag0="ag --depth 0"

# python
alias p="ipython3"
# alias p2="ipython"
alias py="python3"
# alias py2="python"
alias pip="pip3"
function ipdb() { ipython3 --pdb --c="%run $@"; }
alias cprofile="python -m cProfile"
export PYLINTRC=~/Dropbox/.pylintrc

# util
alias diff="colordiff"
# tunnel host port
function ssht() { pkill -f $2:localhost:$2; ssh -fNL $2:localhost:$2 $1; }
function cd-new() { mkdir -p $1; cd $1; }

# prompt for overwrite
alias cp="cp -i"
alias mv="mv -i"

# autoenv
source "$DIR/autoenv.sh"

# heroku
alias deploy="git push heroku master" # this is so cool!

# misc
alias makepwd="java -jar ~/Dropbox/shibboleth/make.jar"

# emacs settings
export EDITOR="emacsclient -c"
alias e="emacsclient -nc"
alias emacs-debug="/Applications/Emacs.app/Contents/MacOS/Emacs --debug-init"

# find by name
alias f="find . -type f -name"

# clipboard works with pipes:
# foo | clipboard will write stdin to the clipboard
# clipboard | bar will write clipboard to stdout
# todo: linux paste
function clipboard {
    ## input
    if [[ "$(uname)" == "Darwin" ]]; then
        alias read_clipboard=pbcopy
    elif [[ "$(uname)" == "Linux" ]]; then
        alias read_clipboard="xsel -ib"
    fi

    if ! tty -s; then  # input is piped
        # drop last newline
        tr -d '\n' | $(read_clipboard)
    fi

    ## output
    ## todo: linux paste
    if [ ! -t 1 ]; then  # output is piped
        pbpaste
        echo # newline
    fi
}

source "${DIR}/prompt.sh"

# rd (read): cat or ls depending on file type
function rd {
    local arg=$1
    if [[ -f "${arg}" ]]; then
        if [[ "$2" = "-h" ]]; then    # head
            head -n $3 ${arg}
        elif [[ "$2" = "-t" ]]; then  # tail
            tail -n $3 ${arg}
        elif [[ "$2" = "-c" ]]; then  # cat
            cat ${arg}
        else                          # default
            head -n 40 ${arg}
        fi
    else
        if [[ "$(uname)" == "Darwin" ]]; then
            ls "$@"
        else
            ls -I "*.pyc" "$@"
        fi
    fi
}

function ltx {
    if [[ $# -eq 0 ]]; then
        if [[ $(ls -l | grep tex | wc -l) -ne 1 ]]; then
            echo "ERROR: more than one latex file, please specify"
            return
        fi
        f=$(ls -l | grep tex | rev | cut -d' ' -f1 | rev)
    else
        f=$1
    fi
    filename=${f%.tex}
    pdflatex $f && open ${filename}.pdf
    rm ${filename}.log
    rm ${filename}.aux
}

# linux alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias start-tps='cd ~/tps; clj -X server/run-local'

function fox {
    echo ' ,-.      .-,'
    echo ' |-.\ __ /.-|'
    echo ' \  `    `  /'
    echo ' / _     _  \'
    echo ' | _`o  o _ |'
    echo ' '._=/  \=_.''
    echo '   {`\()/`}`\'
    echo '   {      }  \'
    echo '   |{    }    \'
    echo '   \ '--'   .- \'
    echo '   |-      /    \'
    echo '   | | | | |     ;'
    echo '   | | |.;.,..__ |'
    echo ' .-'';`         `|'
    echo '/    |           /'
    echo '`-../____,..----` '
    echo ''
}
