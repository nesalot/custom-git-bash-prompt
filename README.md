# My Windows Git Bash Settings

I use MAC OS 90% of the time for Development work, Trying to also be proficient at Windows Development and hone in similar settings on Windows that I use for MAC. I installed Git Bash instead of using Powershell or CMD so I could keep muscle memory workflows. 

I have spent countless hours building out a custom `.bashrc` file instead of using ZSH (because I wanted to learn) that will give me a custom terminal prompt that I enjoy that includes username, directory and git information. This was all coded by me for learning purposes.

![423407701-9d4a7cee-c604-4df9-b8c5-9c614a7bbce1](https://github.com/user-attachments/assets/ad47bb31-b6af-4f9e-b9bb-407091d2a699)

### Current Features:
- Username (blue) & Directory (purple)
- Branch Name (Green if branch matches repo, Yellow if changes are found)
- Behind (↓) & Ahead (↑) Status
- Staged (+) & Unstaged (-) Status
- Untracked (?) Status
- Nerd Font Glyphs - Removes standard status icons and uses Nerd Font Glyphs instead. [Need to install Nerd Font to work](https://www.nerdfonts.com/#home)
- Debug Mode - Outputs branch & all status counts to terminal
- Test Mode - Shows all status icons & counts with sample values
- Simple Mode - Turns off all status icons & counts, Only showing a red X next to branch indicating not clean. Keeping branch color settings (green for clean, yellow for changes)
- Compact Mode - Turns off all status icons & counts, Shows a Colored `❱` at end of prompt for each status instead of the symbols. Keeping branch color settings (green for clean, yellow for changes)
- Fully Configurable Options - Able to toggle each individual or all status icons or counts on/off

---

### Windows Terminals I've been using:
- Windows Terminal (https://github.com/microsoft/terminal)
- Warp for Windows (I've been loving the AI features) (https://www.warp.dev)

---

## How to use `.git_prompt.sh` in your own project:

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

---

<details>
  <summary><h3>My TODO List</h3></summary>

- [X] Separate Prompt Logic to be more modular
  - [X] Move Git Logic to it's own shell script
  - [X] Update .bashrc to only include basic logic
  - [X] Source any extra logic and append to PS1
- [X] Move Staged Changes inside parentheses
- [X] Move Untracked Changes inside parentheses
- [X] De Clutter visually when multiple cases are true (color code better? Or better separation?)
- [X] Configuration Section - Make all colors, symbols and individual status configurable, Will make it easy to maintain and change values
  - [ ] Configuration in `.basrc` to change username and directory color
  - [ ] Configuration in `.bashrc` to toggle which standard non git options you want to show
  - [X] Colors - Remove hard coded colors in `.git_prompt` main code, replace with variables that are configured at top
  - [X] Status Symbols - Remove hard coded status symbols in `.git_prompt`, replace with variables that are configured at top 
  - [X] Show Status on/off Toggle - Create config at top of `.git_prompt` to show/hide individual status
  - [X] Create a `Test Mode` config in `.git_prompt` that will allow me to turn everything on for testing, all status will show even if none are true. 
  - [X] Create a `Debug Mode` in `.git_prompt` config that will output the count of each status 
- [X] Implement Nerd Font Icons
  - [X] Add Config to toggle these on/off OR use standard ↑ ↓ icons
  - [ ] Add more Nerd Icon sets to pick from (Group 1, Group 2, Group 3)
- [X] Expand Color Options (Had 3, now have 7)
- [X] Replace variable names with more descriptive names (ex: `prompt_components` vs. `git_info`)
- [X] Add detailed comments to explain each part/section for others
- [ ] Play around with Background Color option vs no background and colored letters
- [X] Add a Simple Mode Setting that will turn off all status Icons & Counts, Only show a red X next to branch indicating not clean. Still keep the basic two color setting for green for clean, yellow for not clean with red X. 
- [X] Add an option with compact mode to show Colored > at end of prompt for each status.

  
</details>

---

<details open>
<summary><h2>Changelog Screenshots</h2></summary>

<details>
<summary><h4>03-20-2025 - Implemented Compact Mode</h4></summary>
  
![2025-03-20 23_42_44-Window](https://github.com/user-attachments/assets/038ae228-c4d0-443d-ac2a-c77fd0c20590)<br>Screenshot of `COMPACT_MODE` Setting that will turn off all status Icons & Counts, Shows a Colored ❱ at end of prompt for each status.
</details>

<details>
<summary><h4>03-19-2025 - Implemented Simple Mode</h4></summary>
  
![2025-03-19 22_05_13-Window](https://github.com/user-attachments/assets/5dd904b4-11ad-40ae-821e-ef0fb589b2ce)<br>Screenshot of `SIMPLE_MODE` Setting that will turn off all status Icons & Counts, Only show a red X next to branch indicating not clean. Still keeping the basic two color setting for green for clean, yellow for not clean.
</details>

<details>
<summary><h4>03-18-2025 - Implemented Nerd Font Gylphs</h4></summary>
 
![2025-03-18 05_54_29-Window](https://github.com/user-attachments/assets/cb8d44a0-515f-49cc-a4df-dcdfde661684)<br>Screenshot of Nerd Font Glyphs set, plan to add more glyph sets to choose from

</details>

<details>
<summary><h4>03-17-2025 - Implemented Test & Debug Mode along with Configuration Settings</h4></summary>

![2025-03-17 03_59_02-Window](https://github.com/user-attachments/assets/f3c3c5c5-f0ab-4f4c-a2b3-241e6c40236c)<br>Screenshot of `DEBUG_MODE` & `TEST_MODE` turn on not inside a git branch, `DEBUG_MODE` echos out status variable values to the terminal while `TEST_MODE` sets up fake variable values to test all status so you don't have to recreate each scenario

<br>

![2025-03-17 04_00_23-Window](https://github.com/user-attachments/assets/9d4a7cee-c604-4df9-b8c5-9c614a7bbce1)<br>Screenshot of `DEBUG_MODE` turned on but `TEST_MODE` turn off inside a working git branch, Green branch name = no changes found, yellow branch name means changes found with included status for each found

<br>

![2025-03-17 04_01_20- git_prompt sh - Cursor](https://github.com/user-attachments/assets/252a98d2-3b24-43d7-b01b-63e7ab2cd677)<br>Screenshot of work done today to create and separate configuration options from implementation logic

</details>

<details>
<summary><h4>03-15-2025 - Initial Release Screenshot</h4></summary>
  
![2025-03-15 07_22_58-proficient - Google Search](https://github.com/user-attachments/assets/510fc541-d91e-4019-a5ea-6a4ae32a5715)<br>Screenshot of Current WIP Bash Prompt showing several cases for testing

</details>

</details>

---

<details open>
<summary><h2>Changelog</h2></summary>

<details>
<summary><h4>[1.5] - 03-20-2025</h4></summary>

### Added
- Implemented `COMPACT_MODE` Setting that will turn off all status Icons & Counts, Still keeping the basic two color branch name setting (green for clean, yellow for not clean)
- Created `COMPACT_MODE` config option to toggle mode on/off
- In `COMPACT_MODE` Shows a Colored ❱ at end of prompt for each status.

</details>

<details>
<summary><h4>[1.4.0] - 03-19-2025</h4></summary>

### Added
- Implemented `SIMPLE_MODE` Setting that will turn off all status Icons & Counts, Still keeping the basic two color branch name setting (green for clean, yellow for not clean)
- Created `SIMPLE_MODE` config option to toggle mode on/off
- In `SIMPLE_MODE` since all status Icons & Counts were gone, added a Red "X" on right side of branch name when there is branch changes to visually see your not in sync.

</details>

<details>
<summary><h4>[1.3.0] - 03-18-2025</h4></summary>

### Added
- Implemented Nerd Font Glyphs
- Created config to toggle Nerd Fonts Glyphs on/off vs. standard icons

</details>

<details>
<summary><h4>[1.2.0] - 03-17-2025</h4></summary>

Today was a big day! :fire: Added/Changed a lot with the below progress. 

### Added
- **Added Configurability**
  - Added dedicated configuration section with clear header comments for easy modification
  - Separated configuration options from implementation logic
  - Added `Show Status` toggle config to turn each status on/off
  - Added `SHOW_COUNTS` toggle to control displaying numeric values vs. symbols only
  - Added `DEBUG_MODE` that outputs all variables to stderr for troubleshooting
  - Implemented `TEST_MODE` with configurable test values for easy visual testing
- **Reorganized & Improved Code Structure**
  - Grouped related functionality together for better code organization
  - Added detailed comments explaining purpose of each section
  - Improved spacing between status components for better readability
  - Created consistent formatting approach using helper functions
- **Added Color Options**
  - Expanded color definitions beyond the original green/yellow/blue
  - Added distinct colors for different repository states
  - Implemented consistent color application logic based on repo status
  - Changed color assignments to ensure each git status has a unique color
### Changed
- **Improved Status Display**
  - Fixed issue with staged/untracked indicators appearing outside parentheses
  - Removed confusing `DIVERGED_SYMBOL` in favor of separate ahead/behind indicators
- **Enhanced Maintainability**
  - Replaced generic variable names with more descriptive ones (`prompt_components` vs. `git_info`)
  - Implemented array-based approach for cleaner string building
  - Standardized error handling and redirection across git command
- **Improved Performance**
  - Added conditional execution for expensive remote status checks
  - Implemented early return for directories not under git control
  - Reduced redundant command executions
 
</details>

<details>
<summary><h4>[1.1.0] - 03-16-2025</h4></summary>
  
### Added
- Added "On" before branch name if found

### Changed
- Separated prompt logic to be more modular
- Moved Git Logic to it's own shell script called `.git_prompt`
- Updated `.bashrc` to only include basic logic
- Source `.git_prompt` and append to PS1
- Moved Staged Changes inside branch parentheses
- Moved Untracked changes inside branch parentheses

</details>

<details>
<summary><h4>[1.0.0] - 03-15-2025</h4></summary>
  
### Initial Release

</details>

</details>
