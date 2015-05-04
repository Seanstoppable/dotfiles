export LSCOLORS=Gxfxcxdxbxegedabagacad

set bell-style visible

if [ -d ~/.dotfiles/environment_imports ] ; then
  for file in `ls -A ~/.dotfiles/environment_imports` ; do
    source ~/.dotfiles/environment_imports/$file
  done
fi

PATH="$PATH:/usr/local/sbin:/usr/sbin:/sbin"

PATH="$HOME/.dotfiles/bin:$PATH"

export EDITOR=vim

# put ~/bin first on PATH
if [ -d "$HOME/bin" ]; then
  PATH="$HOME/bin:$PATH"
fi

### Bashhub.com Installation
if [ -f ~/.bashhub/bashhub.sh ]; then
    source ~/.bashhub/bashhub.sh
fi
