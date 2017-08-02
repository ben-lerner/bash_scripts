# set .bash_profile to:
# source ~/bash_scripts/profile

# for emacs, set .bashrc to source ~/.bashprofile; cd

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# colorization
export TERM=xterm-256color

# bash_completion, whatever that is.
# if [ -f $(brew --prefix)/etc/bash_completion ]; then
#   . $(brew --prefix)/etc/bash_completion
# fi

# Set architecture flags
export ARCHFLAGS="-arch x86_64"
# Ensure user-installed binaries take precedence
export PATH=/usr/local/bin:~/bin:/usr/texbin:$PATH

# ripgrep
export PATH=/Users/bl/ripgrep/target/release:$PATH
alias rg="rg -i"

# git
alias m="master"
alias gdiff="git diff"
alias co="git checkout"
alias add="git add"
alias gc="git commit -am"
alias br="git branch"
alias branch_times='for k in `git branch | sed s/^..//`; do echo -e `git log -1 --pretty=format:"%Cgreen%ci %Cblue%cr%Creset" $k --`\\t"$k";done | sort'
function gcp() { git commit -am "$1"; git push; }
alias push="git push"
alias pull="git pull --all"
alias merge="git merge"
alias gmv="git mv"
alias continue="git rebase --continue"
alias git_branch_name="git branch | grep '*' | awk '{print \$2}'"
alias log="git log --abbrev-commit"
function land() { arc land $(git_branch_name) --onto master; }
alias rb="git rebase"
function set_upstream() { push --set-upstream origin $(git_branch_name); }
function makebranch() { co -b $1; set_upstream; }
function cleanbranch() { br -d $1; push origin :$1; }


# go
export GOPATH=~/go
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# clojure
alias repl="lein repl"
alias cl="lein exec"
alias lrun="lein run"
alias lmake="lein uberjar"

# python
alias p="ipython"
alias p3="ipython3"
alias py="python"
alias py3="python3"
function ipdb() { ipython --pdb --c="%run $@"; }
alias cprofile="python -m cProfile"
alias d="deactivate"
export PYLINTRC=~/Dropbox/.pylintrc

# alias ls="gls --ignore='*.pyc' --color"
# alias nls="/bin/ls" # normal ls

alias c="clear"

# util
alias diff="colordiff"
# tunnel host port
function ssht() { pkill -f $2:localhost:$2; ssh -fNL $2:localhost:$2 $1; }

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
eval "$(thefuck --alias)"
ulimit -n 8192

# emacs settings
alias emacsclient=ec
export EDITOR=~/bin/edit # https://www.emacswiki.org/emacs/EmacsClient

# find by name
alias f="find . -type f -name"

# git prompt
source "$DIR/git-prompt.sh"

#export GIT_PS1_STATESEPARATOR="ababab" # doesn't work?
export GIT_PS1_SHOWCOLORHINTS="true"
export GIT_PS1_SHOWUPSTREAM="auto verbose"# verbose
export PROMPT_COMMAND='__git_ps1 "\u:\W" " [λ] "'

# Rust
# export PATH=$PATH:/Users/bl/.cargo/bin
