export LSCOLORS=Gxfxcxdxbxegedabagacad

set bell-style visible

if [ -d ~/.dotfiles/.environment_imports ] ; then
  for file in `ls -A ~/.dotfiles/.environment_imports` ; do
    source ~/.dotfiles/.environment_imports/$file
  done
fi

### Bashhub.com Installation
if [ -f ~/.bashhub/bashhub.sh ]; then
    source ~/.bashhub/bashhub.sh
fi
