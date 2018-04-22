# Paths
# Use brew php ie.
# brew install homebrew/php/php55
# PHP="$(brew --prefix homebrew/php/php55)/bin"
# PHP="$(brew --prefix homebrew/php/php56)/bin"
HOMEBREW="/usr/local/bin"
SBIN="/usr/local/sbin"
DOTFILES="/Users/biscii/.dotfiles/bin"
ZPLUG="/Users/biscii/.zplug/bin"
LOCAL_NPM="./node_modules/.bin"
YARN="$HOME/.yarn/bin"
export PATH=$HOMEBREW:$SBIN:$LOCAL_NPM:$YARN:$DOTFILES:$ZPLUG:$PATH
