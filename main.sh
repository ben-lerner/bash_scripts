# set .bash_profile to:
# source ~/bash_scripts/main.sh


DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "${DIR}/vars.sh"
source "${DIR}/git-profile.sh"

# for emacs to source correctly
if [ ! -f ~/.bashrc ]; then
    echo "source ~/.bash_profile; cd" > ~/.bashrc
fi

# clojure
alias "deps-update"="clojure -Aoutdated --update"

# ripgrep
export PATH=/Users/bl/ripgrep/target/release:$PATH
alias rg="rg -i"
alias rg0="rg --maxdepth 0"
alias ag0="ag --depth 0"

# go
export GOPATH=~/go
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# python
alias p="ipython3"
alias p2="ipython"
alias py="python3"
alias py2="python"
function ipdb() { ipython --pdb --c="%run $@"; }
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

# Settings PATH for Python 2.7
export PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"

# autoenv
source "$DIR/autoenv.sh"

# heroku
alias deploy="git push heroku master" # this is so cool!

# misc
alias makepwd="java -jar ~/Dropbox/shibboleth/make.jar"
# eval "$(thefuck --alias)"
ulimit -n 8192

# emacs settings
export EDITOR=~/bin/edit # https://www.emacswiki.org/emacs/EmacsClient
alias e="emacsclient -nc"
alias emacs-debug="/Applications/Emacs.app/Contents/MacOS/Emacs --debug-init"

# find by name
alias f="find . -type f -name"

# clipboard
if [[ "$(uname)" == "Darwin" ]]; then
    alias clipboard=pbcopy
elif [[ "$(uname)" == "Linux" ]]; then
    alias clipboard="xsel -ib"
fi

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

# linux alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
