# alias update=
# "cd ~/bash_scripts; pull; push; cd ~/todo; pull; push; cd ~/emacs; pull; push;
# cd ~/sicp; pull; push; cd"

WD=$(pwd)

for DIR in 'bash_scripts' 'todo' 'emacs' 'sicp'; do
    echo updating $DIR
    cd ~/$DIR
    git commit -am "auto-update"
    git pull
    git push
done

cd $WD
