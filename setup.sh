#/bin/sh

mkdir -p ~/bin

ln -sf ~/.dotfiles/irbrc ~/.irbrc
ln -sf ~/.dotfiles/psqlrc ~/.psqlrc
ln -sf ~/.dotfiles/vim ~/.vim
ln -sf ~/.dotfiles/vimrc ~/.vimrc
cp ~/.dotfiles/gitconfig.global ~/.gitconfig

./brew.sh
./osxsetup.sh

mkdir -p ${XDG_CONFIG_HOME:=$HOME/.config}
ln -s ~/.vim $XDG_CONFIG_HOME/nvim
ln -s ~/.vimrc $XDG_CONFIG_HOME/nvim/init.vim
