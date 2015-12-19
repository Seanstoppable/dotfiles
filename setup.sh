#/bin/sh

mkdir -p ~/bin

ln -sf ~/.dotfiles/irbrc ~/.irbrc
ln -sf ~/.dotfiles/psqlrc ~/.psqlrc
ln -sf ~/.dotfiles/vim ~/.vim
ln -sf ~/.dotfiles/vimrc ~/.vimrc
cp ~/.dotfiles/gitconfig.global ~/.gitconfig

./osxsetup.sh

mkdir -p ${XDG_CONFIG_HOME:=$HOME/.config}
ln -s ~/.dotfiles/vim $XDG_CONFIG_HOME/nvim
ln -s ~/.dotfiled/vimrc $XDG_CONFIG_HOME/nvim/init.vim
