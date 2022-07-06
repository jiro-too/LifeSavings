prompt() {
  echo '%B%b '
}

session() {
  #echo "%F{green}(%n%F{red}@%F{blue}%m) "
  echo "%F{red}❯%F{yellow}❯%F{green}❯%F{white} "
}

path() {
  #echo '%F{white}%B%c%b%f '
  echo '%F{cyan}%(5~|%-1~/…/%3~|%4~)'
}

git_current_branch() {
  local ref
  ref=$(command git symbolic-ref --quiet HEAD 2> /dev/null)
  local ret=$?
  if [[ $ret != 0 ]]; then
    [[ $ret == 128 ]] && return  # no git repo.
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
  fi
  echo ${ref#refs/heads/}
}

git_status() {
  BRANCH=`git_current_branch`
  if [ ! -z $BRANCH ]; then
    if [ ! -z "$(git status --short)" ]; then
      echo -n "%F{white} on %F{green}%B$BRANCH%b"
    else
      echo -n "%F{white} on %F{red}%B$BRANCH%b"
    fi
    echo -n '%F{white}%f'
  fi
}

function preexec() {
  timer=$(($(date +%s%0N)/1000000))
}

function precmd() {
  if [ $timer ]; then
    now=$(($(date +%s%0N)/1000000))
    elapsed=$(($now-$timer))

    export RPROMPT="%F{cyan}${elapsed}ms %{$reset_color%}"
    unset timer
  fi
}

function precmd(){
echo ""
}


NEWLINE=$'\n'
PS1='$(path)$(git_status)$(prompt)${NEWLINE}$(session)'
