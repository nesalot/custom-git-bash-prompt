# Enable color support
export TERM=xterm-256color

# Configure command line colors
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# History control
HISTSIZE=10000
HISTFILESIZE=20000
HISTCONTROL=ignoreboth

#append to history, don't overwrite
shopt -s histappend


# Color definitions (without PS1 escaping brackets)
RED="\033[0;31m"
GREEN="\033[0;32m"
BLUE="\033[0;34m"
YELLOW="\033[0;33m"
PURPLE="\033[0;35m"
CYAN="\033[0;36m"
RESET="\033[0m"

# Function to set the prompt
set_bash_prompt() {
  # Capture the exit status of the last command
  local last_status=$?
  
  # Get Git branch
  local branch=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
  
  # Start with basic prompt
  PS1="${BLUE}\u${RESET} ${PURPLE}\w${RESET} "

  if [ -n "$branch" ]; then
    # Check for staged changes
    local staged=$(git diff --staged --name-only 2> /dev/null | wc -l)
    # Check for unstaged changes
    local unstaged=$(git diff --name-only 2> /dev/null | wc -l)
    # Check for untracked files
    local untracked=$(git ls-files --others --exclude-standard 2> /dev/null | wc -l)
    
    # Build branch info
    local branch_info="${branch}"
    
    # Add unstaged indicator if needed
    if [ "$unstaged" -gt 0 ]; then
      branch_info="${branch_info} !${unstaged}"
    fi
    
    # Check for ahead/behind status
    if git rev-parse --abbrev-ref @{upstream} &>/dev/null; then
      local ahead=$(git rev-list --count @{upstream}..HEAD 2> /dev/null)
      local behind=$(git rev-list --count HEAD..@{upstream} 2> /dev/null)
      
      if [ "$ahead" -gt 0 ] && [ "$behind" -gt 0 ]; then
        branch_info="${branch_info} ↕${ahead}↓${behind}"
      elif [ "$ahead" -gt 0 ]; then
        branch_info="${branch_info} ↑${ahead}"
      elif [ "$behind" -gt 0 ]; then
        branch_info="${branch_info} ↓${behind}"
      fi
    fi
    
    # Determine branch color based on changes
    if [ "$unstaged" -gt 0 ]; then
      # Branch is yellow with unstaged changes
      PS1+="${YELLOW}(${branch_info})${RESET} "
    else
      # Branch is green with no unstaged changes
      PS1+="${GREEN}(${branch_info})${RESET} "
    fi
    
    # Add other status indicators
    if [ "$staged" -gt 0 ]; then
      PS1+="${GREEN}+${staged}${RESET} "
    fi
    if [ "$untracked" -gt 0 ]; then
      PS1+="${BLUE}?${untracked}${RESET} "
    fi
  fi
  
  # Add right arrow instead of dollar sign
  PS1+="${CYAN}→${RESET} "
}

# Set PROMPT_COMMAND to use our function
PROMPT_COMMAND=set_bash_prompt

#prompt customization
#PS1="\[\e[32m\]\u\[\e[0m\] \[\033[01;34m\]\w\[\033[00m\] "