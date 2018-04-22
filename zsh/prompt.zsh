autoload colors && colors
# http://github.com/ehrenmurdick/config/blob/master/zsh/prompt.zsh

# Map the git binary
if
  (( $+commands[git] ))
then
  git="$commands[git]"
else
  git="/usr/bin/git"
fi

_git_branch() {
  echo $($git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
}

_git_dirty() {
  IS_GIT_REPO="$(git rev-parse --is-inside-work-tree 2>/dev/null)"

  if [ "$IS_GIT_REPO" ]; then
    if [[ $($git status --porcelain) == "" ]]
    then
      echo "on %{$fg_bold[green]%}$(git_prompt_info)%{$reset_color%}"
    else
      echo "on %{$fg_bold[red]%}$(git_prompt_info)%{$reset_color%}"
    fi
  else
    # Not in a git repo
    echo "-"
  fi
}

_git_prompt_info () {
  echo "git_prompt_info()"
  echo "git_prompt_info()"
  echo "git_prompt_info()"
 ref=$($git symbolic-ref HEAD 2>/dev/null) || return
# echo "(%{\e[0;33m%}${ref#refs/heads/}%{\e[0m%})"
 echo "${ref#refs/heads/}"
}

_unpushed () {
  $git cherry -v @{upstream} 2>/dev/null
}

_requires_push () {
  if [[ $(_unpushed) == "" ]]
  then
    echo " "
  else
    echo " with %{$fg_bold[magenta]%}unpushed%{$reset_color%} "
  fi
}

_current_directory() {
  echo "%{$fg_bold[cyan]%}${PWD/#$HOME/~}%{$reset_color%}"
}

# Hook
#   precmd()
#
#   Executed before each prompt.
#
precmd() {
  title "zsh" "%m" "%55<...<%~"
  set_prompt
}

# Hook
#   chpwd()
#
#   Executed whenever the current working directory is changed.
#
chpwd() {
  # void
}

# Set the prompt
set_prompt () {
  export PROMPT=$'\nin $(_current_directory) $(_git_dirty)$(_requires_push)\n› '
}
