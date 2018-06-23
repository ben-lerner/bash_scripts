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
alias rb="git rebase"
function set_upstream() { push --set-upstream origin $(git_br_name); }
function makebranch() { co -b $1; set_upstream; }
function cleanbranch() { br -d $1; push origin :$1; }

# arc
function land() { arc land $(git_br_name) --onto master; }

# navigation
function repos {
    for dir in $(ls -1 ${HOME});
    do
        if [[ -d "${HOME}/${dir}/.git" ]]; then
            echo "${dir}"
        fi
    done
}

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
        echo "not in git directory"
    fi
}

# navigate git repos
function nv {
    if [[ -n $1 ]] && [[ $1 != "@" ]]; then  # navigate to directory
        target_dir=$1
        if [[ ${target_dir} = *@ ]]; then  # parse "@"
            set -- @  # set $1 to @
            target_dir=${target_dir%?}
        fi
        if [[ $2 = "@" ]]; then  # work for "foo@" and "foo @"
            set -- @
        fi
        if [[ -d "${HOME}/${target_dir}/.git" ]]; then
            cd "${HOME}/${target_dir}"
        else
            echo "~/${target_dir} does not exist or is not a git repo"
            return
        fi
    fi

    # navigate within directory
    in_git_dir=$(git rev-parse --is-inside-work-tree 2> /dev/null)
    if [[ $in_git_dir = "true" ]]; then
        if [[ $1 = "@" ]]; then  # go to last-edited dir
            cd $(dirname $(last-edited-file))
        else  # go to top-level dir
            cd $(git rev-parse --show-toplevel)
        fi
    else
        echo "not in git directory"
        return
    fi
}

function _nv {
    local cur=${COMP_WORDS[COMP_CWORD]}
    if [ "$COMP_CWORD" -eq "1" ]; then
        COMPREPLY=( $(compgen -W "$(repos)" -- $cur) )
    else
        COMPREPLY=()
    fi
}

complete -F _nv nv
