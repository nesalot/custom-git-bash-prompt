#!/bin/bash

# Color definitions for Git status
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
BLUE="\033[0;34m"
RESET="\033[0m"

# Function to get Git prompt information
get_git_prompt() {
  # Get Git branch
  local branch=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
  
  # If not in a git repository, return empty string
  if [ -z "$branch" ]; then
    echo ""
    return
  fi
  
  local git_info=""
  
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
    git_info+="${YELLOW}(${branch_info})${RESET} "
  else
    # Branch is green with no unstaged changes
    git_info+="${GREEN}(${branch_info})${RESET} "
  fi
  
  # Add other status indicators
  if [ "$staged" -gt 0 ]; then
    git_info+="${GREEN}+${staged}${RESET} "
  fi
  if [ "$untracked" -gt 0 ]; then
    git_info+="${BLUE}?${untracked}${RESET} "
  fi
  
  echo "$git_info"
}

# Export the function so it's available to bash
export -f get_git_prompt