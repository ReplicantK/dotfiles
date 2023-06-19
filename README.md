# About
Most of the files in this repo are supposed to be found in the home folder as dot files. 
Symbolic links are created with the `setup.sh` script to standardize the user's working environment 
and ease of use across different operating systems (i.e., GNU/Linux, macOS).

The following assumes that the (this) GitHub local repository is found in the home folder.

**Note:** when running the `setup.sh` script, a symbolic link called `.ideavimrc` is created in 
the home directory. This file is _not_ present in this repo but is linked to the vimrc file 
that exists in this repo. The purpose of this symbolic link is to enable the IdeaVim plugin 
for the IntelliJ IDEA IDE.

---

## Installation
1. Make the `setup.sh` script executable if it is not already by running `chmod +x setup.sh`.
2. Run `setup.sh` with `./setup.sh`.

---

## More Information on These Files
- `RectangleConfig.json`: settings for the Rectangle window manager for macOS.
- `ublock.txt`: settings for the uBlock Origin extension.
- `setup.sh`: shell script that creates all the symbolic links for the files listed below in an automated way.
- `zshrc`: custom Zsh settings.
- `colors`: directory that holds custom Vim themes.
- `gitconfig`: global Git configuration file.
- `gitignore`: global Git ignore file.
- `mpv.conf`: settings and theming for the MPV CLI video player.
- `tmux.conf`: settings and theming for the Tmux terminal multiplexer.
- `vimrc`: nice-to-have options in Vim.
- `zathurarc`: settings and theming for the CLI Zathura PDF viewer.
