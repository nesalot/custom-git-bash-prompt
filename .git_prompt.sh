#!/bin/bash

# Color definitions for Git status
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
BLUE="\033[0;34m"
RED="\033[0;31m"
PURPLE="\033[0;35m"
CYAN="\033[0;36m"
ORANGE="\033[38;5;208m"
RESET="\033[0m"

# Function to get Git prompt information
get_git_prompt() {

  ######################################################################
  # Configuration section - edit these to customize your prompt
  ######################################################################

  # Display options
  local DEBUG_MODE=false            # Set to true to enable debug output
  local TEST_MODE=false             # Set to true to show all indicators with sample values
  local SHOW_NERDFONT_GLYPHS=false  # Set to true to use Nerd Font glyphs instead of text symbols
  
  # Status display toggles
  local SHOW_COUNTS=true          # Set to false to show only symbols without numbers
  local SHOW_UNSTAGED=true        # Display unstaged changes
  local SHOW_STAGED=true          # Display staged changes
  local SHOW_UNTRACKED=true       # Display untracked files
  local SHOW_AHEAD=true           # Display commits ahead of remote
  local SHOW_BEHIND=true          # Display commits behind remote

  # Status symbols (defaults - will be overridden by Nerd Font glyphs if enabled)
  local UNSTAGED_SYMBOL="-"
  local STAGED_SYMBOL="+"
  local UNTRACKED_SYMBOL="?"
  local AHEAD_SYMBOL="↑"
  local BEHIND_SYMBOL="↓"

  # Use Nerd Font glyphs if enabled
  if [ "$SHOW_NERDFONT_GLYPHS" = true ]; then
  local UNSTAGED_SYMBOL="󰍷 "
  local STAGED_SYMBOL=" "
  local UNTRACKED_SYMBOL=" "
  local AHEAD_SYMBOL=" "
  local BEHIND_SYMBOL=" "
  fi

  # Colors for different states
  local CLEAN_COLOR="$GREEN"
  local MODIFIED_COLOR="$YELLOW"
  local UNTRACKED_COLOR="$BLUE"
  local AHEAD_COLOR="$CYAN"
  local BEHIND_COLOR="$PURPLE"
  local STAGED_COLOR="$ORANGE"
  local UNSTAGED_COLOR="$RED"

  ######################################################################
  # Git status collection
  ######################################################################

  # Get Git branch
  local branch=$(git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')

  # If not in a git repository, return empty unless in TEST_MODE
  if [ -z "$branch" ] && [ "$TEST_MODE" = false ]; then
    echo ""
    return
  fi

  # Collect all git status information at once
  local staged=$(git diff --staged --name-only 2>/dev/null | wc -l)
  local unstaged=$(git diff --name-only 2>/dev/null | wc -l)
  local untracked=$(git ls-files --others --exclude-standard 2>/dev/null | wc -l)
  local ahead=0
  local behind=0

  # Get ahead/behind status if we have an upstream branch
  if [ "$TEST_MODE" = false ] && git rev-parse --abbrev-ref @{upstream} &>/dev/null; then
    ahead=$(git rev-list --count @{upstream}..HEAD 2>/dev/null)
    behind=$(git rev-list --count HEAD..@{upstream} 2>/dev/null)
  fi

  # Override with test values when in test mode
  if [ "$TEST_MODE" = true ]; then
    branch="feature/test-branch"
    staged=4
    unstaged=3
    untracked=1
    ahead=5
    behind=2
  fi

  ######################################################################
  # Prompt formatting
  ######################################################################

  # Format count based on configuration
  format_count() {
    local symbol="$1"
    local count="$2"
    local color="$3"

    if [ "$SHOW_COUNTS" = true ]; then
      echo "${color}${symbol}${count}${RESET}"
    else
      echo "${color}${symbol}${RESET}"
    fi
  }

  # Build status information using array for cleaner joining
  local prompt_components=()

  # Determine branch color based on repository state
  local branch_color="$CLEAN_COLOR"
  local has_changes=false
  
  # Check if any changes exist that we're configured to care about
  if [ "$SHOW_UNSTAGED" = true ] && [ "$unstaged" -gt 0 ]; then has_changes=true; fi
  if [ "$SHOW_STAGED" = true ] && [ "$staged" -gt 0 ]; then has_changes=true; fi
  if [ "$SHOW_UNTRACKED" = true ] && [ "$untracked" -gt 0 ]; then has_changes=true; fi
  if [ "$SHOW_AHEAD" = true ] && [ "$ahead" -gt 0 ]; then has_changes=true; fi
  if [ "$SHOW_BEHIND" = true ] && [ "$behind" -gt 0 ]; then has_changes=true; fi

  # Set branch color based on change status
  if [ "$has_changes" = true ]; then
    branch_color="$MODIFIED_COLOR"  # Yellow if any changes detected
  fi

  # Always start with branch name in its appropriate color
  prompt_components+=("${branch_color}${branch}${RESET}")

  # Add file status indicators with appropriate colors if enabled
  [ "$SHOW_UNSTAGED" = true ] && [ "$unstaged" -gt 0 ] && \
    prompt_components+=($(format_count "$UNSTAGED_SYMBOL" "$unstaged" "$UNSTAGED_COLOR"))
  
  [ "$SHOW_STAGED" = true ] && [ "$staged" -gt 0 ] && \
    prompt_components+=($(format_count "$STAGED_SYMBOL" "$staged" "$STAGED_COLOR"))
  
  [ "$SHOW_UNTRACKED" = true ] && [ "$untracked" -gt 0 ] && \
    prompt_components+=($(format_count "$UNTRACKED_SYMBOL" "$untracked" "$UNTRACKED_COLOR"))

  # Show ahead/behind status if enabled
  [ "$SHOW_AHEAD" = true ] && [ "$ahead" -gt 0 ] && \
    prompt_components+=($(format_count "$AHEAD_SYMBOL" "$ahead" "$AHEAD_COLOR"))
  
  [ "$SHOW_BEHIND" = true ] && [ "$behind" -gt 0 ] && \
    prompt_components+=($(format_count "$BEHIND_SYMBOL" "$behind" "$BEHIND_COLOR"))

  # Join all parts with spaces
  local branch_info="${prompt_components[*]}"

  # Determine the parentheses color based on repository state
  local color="$CLEAN_COLOR"
  if [ "$has_changes" = true ]; then
    color="$MODIFIED_COLOR"  # Yellow for parentheses if any changes detected
  fi

  # Print debug information if enabled
  if [ "$DEBUG_MODE" = true ]; then
    echo "DEBUG: branch=$branch unstaged=$unstaged staged=$staged untracked=$untracked ahead=$ahead behind=$behind" >&2
  fi

  # Return formatted git prompt
  echo "${color}(${RESET}${branch_info}${color})${RESET} "
}

# Export the function so it's available to bash
export -f get_git_prompt