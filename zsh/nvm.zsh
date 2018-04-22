# tl;dr
# - Ensure that nvm is installed via the script installer NOT homebrew
# nvm options
export NVM_LAZY_LOAD=true
export NVM_DIR="$HOME/.nvm"

# Create $NVM_DIR if it does not exist
if [ ! -d ~/.nvm ]; then
  mkdir ~/.nvm
fi

# Load nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
# Enable completion
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

