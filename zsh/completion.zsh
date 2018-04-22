if [ -f `brew --prefix`/share/zsh/site-functions ]; then
  . `brew --prefix`/share/zsh/site-functions
fi

HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# matches case insensitive for lowercase
zstyle ':completion:*' menu select
zstyle ':completion:*' completer _complete
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'
