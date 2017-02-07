# set .bash_profile to:
# source ~/bash_scripts/profile

# for emacs, set .bashrc to source ~/.bashprofile; cd

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

# git
alias m="git checkout master"
alias co="git checkout"
alias add="git add"
alias gc="git commit -am"
alias br="git branch"
function gcp() { git commit -am "$1"; git push; }
alias push="git push"
alias pull="git pull --all"
alias gmv="git mv"
alias continue="git rebase --continue"
function makebranch() { git checkout -b $1; git push --set-upstream origin $1; }
function cleanbranch() { git branch -d $1; git push origin :$1; }
alias git_branch_name="git branch | grep '*' | awk '{print \$2}'"
function land() { arc land $(git_branch_name) --onto master; }
alias rebm="git rebase master"
alias set_upstream="git push --set-upstream origin $(git_branch_name)"

# go
export GOPATH=~/go
export GOROOT=/usr/local/opt/go/libexec #GOROOT
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# clojure
alias repl="cd ~/clojure/repl; lein repl"
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

alias ls="gls --ignore='*.pyc' --color"
alias nls="/bin/ls" # normal ls


# util
alias diff="colordiff"

# prompt for overwrite
alias cp="cp -i"
alias mv="mv -i"

# Settings PATH for Python 2.7
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
# adding GEOS to path for shapely library
PATH="/usr/local/Cellar/geos/3.4.2/bin:${PATH}"
export PATH

# navigation
alias edge="cd ~/edge"
alias dn="cd ~/dn"
alias www="cd ~/www"
alias vive="cd ~/vive"
alias dbw="cd ~/Dropbox/caffeine/dashback/dashback_site/www"
alias mm="cd ~/macm-demand-planning"
alias hr="cd ~/Dropbox/job_search/interview_prep/hackerrank"
alias cdemacs="cd ~/Dropbox/emacs"

# colors!
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# autoenv
source ~/bash_scripts/autoenv.sh

# heroku
alias deploy="git push heroku master" # this is so cool!

# misc
alias makepwd="java -jar ~/Dropbox/shibboleth/make.jar"
eval "$(thefuck --alias)"
ulimit -n 8192

# emacs settings
alias test_shell="echo 'shell profile loaded'"

alias emacsclient=ec
export EDITOR=~/bin/edit # https://www.emacswiki.org/emacs/EmacsClient

# find
alias f="find . -type f -name"

# git prompt
source ~/bash_scripts/git-prompt.sh

#export GIT_PS1_STATESEPARATOR="ababab" # doesn't work?
export GIT_PS1_SHOWCOLORHINTS="true"
export GIT_PS1_SHOWUPSTREAM="auto verbose"# verbose
export PROMPT_COMMAND='__git_ps1 "\u:\W" " [λ] "'

# Rust
export PATH=$PATH:/Users/bl/.cargo/bin
