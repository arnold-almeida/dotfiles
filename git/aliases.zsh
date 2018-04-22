# Use `hub` as our git wrapper:
#   http://defunkt.github.com/hub/
hub_path=$(which hub)

if (( $+commands[hub] ))
then
  alias git=$hub_path
fi

# current_branch()
#
#  Description:
#
#   Name of current branch
#
#  Source:
#
#   https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/git/git.plugin.zsh
#
function current_branch() {
  git_current_branch
}

#  List of my git (favoured) aliases
#
#  Source/s:
#  Credit/s:
#
#   - https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/git/git.plugin.zsh
#   - @zholman
#
alias gclean='git pull --prune'
alias gt='git log --all --decorate --oneline --graph'
alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gpo='git push origin HEAD'
alias gpr='git pull --rebase origin HEAD'
alias gd='git diff'
alias gc='git commit'
alias gca='git commit -a'
alias gaa='git add -A'
alias gco='git checkout'
alias gb='git branch'
alias gf='git fetch --all' # upgrade your git if -sb breaks for you. it's fun.
alias gs='git status -sb'
alias grm="git status | grep deleted | awk '{print \$3}' | xargs git rm"
alias gtoday="git log --since '1 day ago' --oneline --author Arnold"
alias gammend="git commit --amend -C HEAD"

# Undo last commit
alias gundo="git reset --soft HEAD^"

# Delete all local branches that have been merged into HEAD. Stolen from
# our favorite @tekkub:
#
#   https://plus.google.com/115587336092124934674/posts/dXsagsvLakJ
alias gflush="git branch -d `git branch --merged | grep -v '^*' | grep -v 'master' | tr -d '\n'`"


# Sync all branches via "git up"
#
#   See: https://github.com/msiemens/PyGitUp
#
alias gup="git-up"


# alias grelease="git log `git describe --tags --abbrev=0`..HEAD --oneline"

#
# Do what you expect from fetch, get and track all remotes.
# Useful in combination with gup
#
#   gremotes
#   gup
# function track_remotes() {
#   for remote in $(git branch -r);
#     do
#       echo "git branch --track $remote";
#     done
# }
# alias gremotes="track_remotes"

# no diff
# git log --color --pretty=oneline --abbrev-commit --after="2017-6-18"

# # With diff
# git log -p --color --pretty=oneline --abbrev-commit --after="2017-6-18"



