# set .bash_profile to:
# source ~/bash_scripts/main.sh


DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "${DIR}/vars.sh"
source "${DIR}/git-profile.sh"

# for emacs to source correctly
if [ ! -f ~/.bashrc ]; then
    echo "source ~/.bash_profile; cd" > ~/.bashrc
fi

# ripgrep
export PATH=/Users/bl/ripgrep/target/release:$PATH
alias rg="rg -i"
alias rg1="rg --maxdepth 1"
alias ag1="ag --depth 1"

# go
export GOPATH=~/go
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# clojure
alias repl="lein repl"
alias clj="lein exec"
alias lrun="lein run"
alias lmake="lein uberjar"

function clj-app {  # set up new clj-app
    lein new app $1
    rm $1/.hgignore
    # set up cider-compatible test layout
    mkdir $1/src/$1/test
    mv $1/test/$1/core_test.clj $1/src/$1/test
    rm -rf $1/test
}

# python
alias p="ipython"
alias p3="ipython3"
alias py="python"
alias py3="python3"
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
