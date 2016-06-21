# set .bash_profile to:
# source ~/Dropbox/bash_scripts/profile

# for emacs, set .bashrc to source ~/.bashprofile; cd

# colorization
export TERM=xterm-256color

# bash_completion, whatever that is.
# if [ -f $(brew --prefix)/etc/bash_completion ]; then
#   . $(brew --prefix)/etc/bash_completion
# fi

# drop username from bash prompt
export PS1="\u: \W \$ "

# Set architecture flags
export ARCHFLAGS="-arch x86_64"
# Ensure user-installed binaries take precedence
export PATH=/usr/local/bin:~/bin:/usr/texbin:$PATH:~/jython2.5.3

alias add="git add"
alias gc="git commit -am"
function gcp() { git commit -am "$1"; git push; }
alias push="git push"
alias pull="git pull --all"
alias gmv="git mv"
function makebranch() { git checkout -b $1; git push --set-upstream origin $1; }
function cleanbranch() { git branch -d $1; git push origin :$1; }

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

## need to run brew install coreutils for this to work:
alias ls="gls --ignore='*.pyc' --color"
alias nls="/bin/ls" # normal ls

# Grep
function rgrep() { grep -rni "$1" --include=".*.$2" .;}
function pygrep() { rgrep "$1" py; }
function cgrep() { rgrep "$1" h; rgrep "$1" c; rgrep "$1" cpp; rgrep "$1" def; }
function clgrep() { rgrep "$1" clj; rgrep "$1" java; }
function gogrep() { rgrep "$1" go; }

# ssh
alias dnssh="ssh -i ~/www/dn.pem ubuntu@datanitro.com"
alias enginessh="ssh -i ~/www/dn.pem ubuntu@engine.datanitro.com"
alias edgessh="ssh -i ~/www/dn.pem ubuntu@edgexl.com"
alias caffssh="ssh -i ~/Dropbox/caffeine/www/caffeine.pem ubuntu@caffeinatedanalytics.com"
alias dbssh="ssh -i ~/Dropbox/caffeine/www/caffeine.pem ubuntu@getdashback.com"
alias macmssh="ssh -i /Users/bl/Dropbox/caffeine/www/caffeine.pem ubuntu@macmillan.caffeinatedanalytics.com"

# prompt for overwrite
alias cp="cp -i"
alias mv="mv -i"

# Settings PATH for Python 2.7
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
# adding GEOS to path for shapely library
PATH="/usr/local/Cellar/geos/3.4.2/bin:${PATH}"
export PATH

# navigation
alias sd="cd ~/go/src/code.uber.internal/infra/statsdex/"
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

# virtualenv management
# if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"
# alias venv="pyvenv virtualenv venv"

# misc
alias makepwd="java -jar ~/Dropbox/shibboleth/make.jar"
#eval "$(thefuck --alias)"

# emacs settings
#if [ "$EMACS" == "t" ]; then
#   export TERM=dumb
#fi
alias test_shell="echo 'shell profile loaded'"
