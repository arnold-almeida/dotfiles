# Map the git binary
if
  (( $+commands[git] ))
then
  git="$commands[git]"
else
  git="/usr/bin/git"
fi

git_dirty() {
  if $git rev-parse --git-dir > /dev/null 2>&1; then
    if [[ $(git diff --stat) != '' ]]; then
      echo "on %{$fg_bold[red]%}$(git_prompt_info)%{$reset_color%}"
    else
      echo "on %{$fg_bold[green]%}$(git_prompt_info)%{$reset_color%}"
    fi
  else
    :
  fi
}

git_prompt_info () {
  ref=$($git symbolic-ref HEAD 2>/dev/null) || return
  echo "${ref#refs/heads/}"
}

unpushed () {
  $git cherry -v @{upstream} 2>/dev/null
}

requires_push () {
  if [[ $(unpushed) == "" ]]
  then
    echo " "
  else
    echo " with %{$fg_bold[magenta]%}unpushed%{$reset_color%} "
  fi
}

current_directory() {
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
  export PROMPT=$'\nin $(current_directory) $(git_dirty)$(requires_push)\n› '
}
