export LSCOLORS=Gxfxcxdxbxegedabagacad

set bell-style visible

if [ -d ~/.dotfiles/environment_imports ] ; then
  for file in ~/.dotfiles/environment_imports/* ; do
    [[ -e $file ]] || break
    # shellcheck source=/dev/null
    source "$file"
  done
fi

PATH="$PATH:/usr/local/sbin:/usr/sbin:/sbin"

PATH="$HOME/.dotfiles/bin:$PATH"

export EDITOR=vim

# put ~/bin first on PATH
if [ -d "$HOME/bin" ]; then
  PATH="$HOME/bin:$PATH"
fi

case $TERM in
  xterm*|rxvt|Eterm|eterm)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\007"'
    ;;
  screen)
    PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\033\\"'
    ;;
esac


### Bashhub.com Installation
if [ -f ~/.bashhub/bashhub.sh ]; then
  # shellcheck source=/dev/null
  source ~/.bashhub/bashhub.sh
fi

### source any local bash
if [ -f ~/.bashrc.local ] ; then
  # shellcheck source=/dev/null
  source ~/.bashrc.local
fi

#include any local aliases
if [ -f ~/.aliases.local ] ; then
  # shellcheck source=/dev/null
  source ~/.aliases.local
fi
