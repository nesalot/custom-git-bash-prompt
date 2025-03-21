# include .aliases if it exists
if [ -f ~/.windows_aliases ]; then
    . ~/.windows_aliases
fi

# Source the git prompt script if it exists
if [ -f ~/.git_prompt.sh ]; then
    . ~/.git_prompt.sh
fi

# Increase history size
HISTSIZE=10000
# Increase file size
HISTFILESIZE=20000
# Ignore duplicate commands and commands starting with space
HISTCONTROL=ignoreboth
# Add timestamp to history
HISTTIMEFORMAT="%F %T "
#  Add history immediately
PROMPT_COMMAND="history -a"

#append to history, don't overwrite
shopt -s histappend
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Color definitions
RED="\033[0;31m"
GREEN="\033[0;32m"
BLUE="\033[0;34m"
YELLOW="\033[0;33m"
PURPLE="\033[0;35m"
CYAN="\033[0;36m"
RESET="\033[0m"

# Function to set the prompt
set_bash_prompt() {
  # Start with basic prompt (as in line 40 of your original .bashrc)
  PS1="${BLUE}\u${RESET} ${PURPLE}\w${RESET} "
  
  # Add git information if available
  local git_info=$(get_git_prompt)
  if [ -n "$git_info" ]; then
    PS1+="on $git_info"
  fi
}

# Set PROMPT_COMMAND to use our function
PROMPT_COMMAND=set_bash_prompt