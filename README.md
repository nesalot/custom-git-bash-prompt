# My Windows Git Bash Settings

I use MAC OS 90% of the time for Development work, Trying to also be proficient at Windows Development and hone in similar settings on Windows that I use for MAC. I installed Git Bash instead of using Powershell or CMD so I could keep muscle memory workflows. 

I have spent countless hours building out a custom `.bashrc` file instead of using ZSH (because I wanted to learn) that will give me a custom terminal prompt that I enjoy that includes username, directory and git information. This was all coded by me for learning purposes.

## Windows Terminals I've been using:
- Windows Terminal
- Warp for Windows (which I've been loving the AI features)

---

#### 3/15 Current Setup
![2025-03-15 07_22_58-proficient - Google Search](https://github.com/user-attachments/assets/510fc541-d91e-4019-a5ea-6a4ae32a5715)<br>*Screenshot of Current WIP Bash Prompt showing several cases for testing*

### Currently Showing:
- Username (blue)
- Directory (purple)
- Branch Name (Green if branch matches repo, Yellow if changes are found)
- Behind/Ahead Changes & Count
- Staged Files
- Unstaged Files
- Untracked Files

  ---

### TODO List:
- [X] Seperate Prompt Logic to be more modular
  - [X] Move Git Logic to it's own shell script
  - [X] Update .bashrc to only include basic logic
  - [X] Source any extra logic and append to PS1
- [ ] Move Staged Changes inside parentheses
- [ ] Move Untracked Changes inside parentheses
- [ ] De Clutter visually when multiple cases are true (color code better? Or better seperation?)
- [ ] Add Nerd Font Icons

  ---

# How to use `.git_prompt.sh` in your own project:

1)  Download `.git_prompt.sh` script and make sure the script executable by entering the following in your terminal: 

```console
  chmod +x ~/.git_prompt.sh
```

2) In your `.bashrc` or `.bash_profile` file make sure to source the script by:

```bash
  # Source the git prompt script if it exists
  if [ -f ~/.git_prompt.sh ]; then
    . ~/.git_prompt.sh
  fi
```
3) Append Git prompt to your `PS1` by:

```bash
  # Add git information if available
  local git_info=$(get_git_prompt)
  if [ -n "$git_info" ]; then
    PS1+="$git_info"
  fi
```

See my [`.bashrc`](https://github.com/nesalot/windows_bash/blob/main/.bashrc) for a working example of how I'm using it. 

:v: Hope you enjoy! :v::
