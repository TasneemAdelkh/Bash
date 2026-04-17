# Bash
# Bash User & Group Management Toolkit

A Bash scripting project that provides a simple terminal-based interface for managing Linux users and groups.

This tool uses **whiptail** to display an interactive menu and helps automate common system administration tasks such as creating users, modifying accounts, managing groups, locking/unlocking users, and changing passwords.

## Features

- Add a new user
- Modify an existing user
  - Change username
  - Change UID
  - Change shell
- Delete a user
- List all users on the system
- Add a new group
- Modify an existing group
  - Change group name
  - Set group members
  - Append new members
- Delete a group
- List all groups on the system
- Disable (lock) a user account
- Enable (unlock) a user account
- Change a user's password
- About section with project information

## Technologies Used

- **Bash Shell Scripting**
- **whiptail** for terminal GUI dialogs
- Standard Linux user/group management commands such as:
  - `useradd`
  - `usermod`
  - `userdel`
  - `groupadd`
  - `groupmod`
  - `groupdel`
  - `chpasswd`

## How It Works

When the script runs, it opens a menu-driven interface where the administrator can choose the required operation.

The script interacts with the Linux system using built-in administration commands to perform user and group lifecycle operations, including:

- user creation
- account modification
- password updates
- group membership management
- account locking and unlocking
- home directory migration when renaming users

## Requirements

- Linux environment
- Bash shell
- `whiptail` installed
- Root or sudo privileges

## Installation

Clone the repository:

```bash
git clone https://github.com/TasneemAdelkh/Bash.git
cd Bash

## Make the script executable:

chmod +x project.sh

## Run the script:

sudo ./project.sh

## Notes

# This script should be run with administrative privileges because it modifies system users and groups.
# Use it carefully on production systems.
# The script is intended for learning, practice, and basic Linux administration automation.

