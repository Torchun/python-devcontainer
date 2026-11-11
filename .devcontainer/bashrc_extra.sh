# Custom bash prompt + git coloring for the devcontainer.
# Sourced from ~/.bashrc (interactive shells only).

# For Git colouring
git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/' | awk '{print " ["$1"]"}'
}

acolor() {
  [[ -n $(git status --porcelain=v2 2>/dev/null) ]] && echo 31 || echo 32
}
_GREEN="\[\033[32m\]"
_BLUE="\[\033[34m\]"
_YELLOW="\[\033[33m\]"
_BOLD_YELLOW="\[\033[01;33m\]"
_RED="\[\033[31m\]"
_RESET="\[\033[00m\]"

PS1="[${_GREEN}\u${_RESET}${_BOLD_YELLOW}@${_RESET}${_BLUE}\h${_RESET}] \W\[\033[\$(acolor)m\]\$(git_branch)\[\033[00m\] \$ "
