#!/bin/sh
command -v nvim > /dev/null 2>&1 || { echo 'ERROR: Program not found: nvim' 1>&2; exit 1; }
command -v git > /dev/null 2>&1 || { echo 'ERROR: Program not found: git' 1>&2; exit 1; }
command -v curl > /dev/null 2>&1 || { echo 'ERROR: Program not found: curl' 1>&2; exit 1; }
[ ! -f 'unix.init.vim' ] && { echo 'ERROR: File not found: unix.init.vim' 1>&2; exit 1; }
[ -z "$HOME" ] && { echo 'ERROR: Home directory not found' 1>&2; exit 1; }

rm -rf ~/.config/nvim/
mkdir -p ~/.config/nvim/autoload/
cp unix.init.vim ~/.config/nvim/init.vim
curl https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim --output ~/.config/nvim/autoload/plug.vim
if [ "$?" -eq 0 ]; then
    nvim -c 'PlugInstall' -c 'qa!'
    echo 'Done'
else
    echo 'ERROR: Cannot get vim-plug'
    exit 1
fi
