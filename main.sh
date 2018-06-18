# set .bash_profile to:
# source ~/bash_scripts/main.sh

# for emacs to source correctly
if [ ! -f ~/.bashrc ]; then
    echo "source ~/.bash_profile; cd" > ~/.bashrc
fi

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# colorization
export TERM=xterm-256color

# Set architecture flags
export ARCHFLAGS="-arch x86_64"
# Ensure user-installed binaries take precedence
export PATH=/usr/local/bin:~/bin:/usr/texbin:$PATH

# ripgrep
export PATH=/Users/bl/ripgrep/target/release:$PATH
alias rg="rg -i"
alias rg1="rg --maxdepth 1"
alias ag1="ag --depth 1"

# git
alias m="master"
alias gdiff="git diff"
function co() {
    if $(git diff --quiet); then
        git checkout $@
    else
        echo "Error: working tree not clean"
    fi
}

function _branches() {
    echo $((git branch 2>/dev/null) | sed s/^..//)
}

function _co () {
    local cur=${COMP_WORDS[COMP_CWORD]}
    if [ "$COMP_CWORD" -eq "1" ]; then {
        COMPREPLY=( $(compgen -W "$(_branches)" -- $cur) )
    }
    else {
        COMPREPLY=( $(compgen -f -- $cur) )
    }
    fi
}

complete -F _co co

alias br="git branch"

function _br () {
    # autocomplete branches for -D
    if [ "$COMP_CWORD" -eq "2" ]; then {
        local cur=${COMP_WORDS[COMP_CWORD]}
        COMPREPLY=( $(compgen -W "$(_branches)" -- $cur) )
    }
    else {
        COMPREPLY=()
    }
    fi
}

complete -F _br br

alias add="git add"
alias gc="git commit -am"
alias branch_times='for k in $(_branches); do echo -e `git log -1 --pretty=format:"%Cgreen%ci %Cblue%cr%Creset" $k --`\\t"$k";done | sort'
function gcp() { git commit -am "$1"; git push; }
alias push="git push"
alias pull="git pull"
alias merge="git merge"
alias gmv="git mv"
alias git_br_name="git rev-parse --abbrev-ref HEAD"
alias log="git log --abbrev-commit --pretty=oneline -10"
function land() { arc land $(git_br_name) --onto master; }
alias rb="git rebase"
function set_upstream() { push --set-upstream origin $(git_br_name); }
function makebranch() { co -b $1; set_upstream; }
function cleanbranch() { br -d $1; push origin :$1; }


# go
export GOPATH=~/go
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# clojure
alias repl="lein repl"
alias clj="lein exec"
alias lrun="lein run"
alias lmake="lein uberjar"

# python
alias p="ipython"
alias p3="ipython3"
alias py="python"
alias py3="python3"
function ipdb() { ipython --pdb --c="%run $@"; }
alias cprofile="python -m cProfile"
export PYLINTRC=~/Dropbox/.pylintrc

# alias ls="gls --ignore='*.pyc' --color"
# alias nls="/bin/ls" # normal ls

# util
alias diff="colordiff"
# tunnel host port
function ssht() { pkill -f $2:localhost:$2; ssh -fNL $2:localhost:$2 $1; }
function cd-new() { mkdir -p $1; cd $1; }

# prompt for overwrite
alias cp="cp -i"
alias mv="mv -i"

# Settings PATH for Python 2.7
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
# adding GEOS to path for shapely library
PATH="/usr/local/Cellar/geos/3.4.2/bin:${PATH}"
export PATH

# colors!
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

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

# Rust
# export PATH=$PATH:/Users/bl/.cargo/bin

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

function clj-app {
    # set up new clj-app
    lein new app $1
    rm $1/.hgignore
    # set up cider-compatible test layout
    mkdir $1/src/$1/test
    mv $1/test/$1/core_test.clj $1/src/$1/test
    rm -rf $1/test
}

# git navigation
function last-edited-file {
    # get the last-edited file in a git directory
    in_git_dir=$(git rev-parse --is-inside-work-tree 2> /dev/null)
    if [[ $in_git_dir = "true" ]]; then
        # find most recently edited file. compare to HEAD~1, not HEAD, in case we haven't
        # touched anything yet.
        echo $(git diff HEAD~1 --name-only -z |
                   xargs -0 -n1 -I{} -- git log -1 --format="%ai {}" {} |
                   sort -r | head -1 |
                   rev | cut -d ' ' -f1 | rev)  # reverse before and after cut to get last field
    else
        echo 'not in git directory'
    fi
}

function gd {
    in_git_dir=$(git rev-parse --is-inside-work-tree 2> /dev/null)
    if [[ $in_git_dir = "true" ]]; then
        if [[ $1 = "@" ]]; then  # go to last-edited dir
            cd $(dirname $(last-edited-file))
        else  # go to top-level dir
            cd $(git rev-parse --show-toplevel)
        fi
    else
        echo 'not in git directory'
    fi
}
