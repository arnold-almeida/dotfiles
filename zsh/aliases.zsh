# # grc overides for ls
# #   Made possible through contributions from generous benefactors like
# #   `brew install coreutils`
# if $(gls &>/dev/null)
# then
#   alias ls="gls -F --color"
#   alias l="gls -lAh --color"
#   alias ll="gls -l --color"
#   alias la='gls -A --color'
# fi

# Quick and dirty cd ..
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Opens the ios-simulator bundled with xocde
alias ios-simulator="open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app"

alias ip-public="dig +short myip.opendns.com @resolver1.opendns.com"
alias ip-local="ipconfig getifaddr en0"
alias reload!='. ~/.zshrc'
alias weather='curl -4 http://wttr.in'
alias moon='curl -4 http://wttr.in/Moon'
alias crypto='node /Users/biscii/Development/open-source/cryptocurrency-cli/index'

# alisa "z" to "j" for jumping around
alias j="z"

# More sane alias that will copy to your clipboard from a pipe
# i.e. cat ~/.ssh/id_rsa.pub | clipboard
alias clipboard='pbcopy'

# List ports in use
# eg.
#   ports :3000
#
# Will list all processes using port 3000
alias ports="lsof -i"
# lsof -n -i4TCP:$PORT | grep LISTEN
# lsof -n -iTCP:$PORT | grep LISTEN
# lsof -n -i:$PORT | grep LISTEN


# Pipe my public key to my clipboard.
alias pubkey="cat ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to clipboard.'"

# Test shell load time\
alias zsh-load-item='for i in $(seq 1 10); do /usr/bin/time zsh -i -c exit; done'
