brew install coreutis tree ag
brew install colordiff

# emacs
ln -s /Applications/Emacs.app/Contents/MacOS/bin/emacsclient /usr/local/bin
# follow: https://emacsformacosx.com/tips

# scheme:
# https://jacksonisaac.wordpress.com/2014/03/25/installing-scheme-on-mac-os-x/

sudo ln -s /Applications/MIT\:GNU\ Scheme.app/Contents/Resources /usr/local/lib/mit-scheme-x86-64
sudo ln -s /usr/local/lib/mit-scheme-x86-64/mit-scheme /usr/local/bin/scheme
sudo ln -s /usr/local/lib/mit-scheme-x86-64/mit-scheme /usr/local/bin/mit-scheme

#arc
arc set-config base master
