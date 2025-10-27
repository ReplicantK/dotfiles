#!/bin/bash
set -e

echo "Setup script launched."
echo -n "Detecting operating system... "

clangd_dir=""

if [[ "$OSTYPE" == darwin* ]]
then
  clangd_dir="$HOME/Library/Preferences/clangd"
  echo "macOS detected"
else
  clangd_dir="$HOME/.config/clangd"
  echo "GNU/Linux detected"
fi

echo -n "Checking for required directories and creating missing ones... "
mkdir -p "$clangd_dir"
mkdir -p "$HOME/.config"
mkdir -p "$HOME/.vim"
mkdir -p "$HOME/.config/mpv"
mkdir -p "$HOME/.config/nvim"
mkdir -p "$HOME/.config/zathura"
mkdir -p "$HOME/.config/kitty"
mkdir -p "$HOME/.config/alacritty"

echo "done"

echo -n "Creating symbolic links... "
ln -sf "$HOME/dotfiles/alacritty.toml" "$HOME/.config/alacritty/alacritty.toml"
ln -sf "$HOME/dotfiles/mpv.conf" "$HOME/.config/mpv/mpv.conf"
ln -sf "$HOME/dotfiles/init.lua" "$HOME/.config/nvim/init.lua"
ln -sf "$HOME/dotfiles/kitty.conf" "$HOME/.config/kitty/kitty.conf"
ln -sf "$HOME/dotfiles/zathurarc" "$HOME/.config/zathura/zathurarc"
ln -sf "$HOME/dotfiles/gitconfig" "$HOME/.gitconfig"
ln -sf "$HOME/dotfiles/tmux.conf" "$HOME/.tmux.conf"
ln -sf "$HOME/dotfiles/vimrc" "$HOME/.vimrc"
ln -sf "$HOME/dotfiles/vimrc" "$HOME/.ideavimrc"
ln -sf "$HOME/dotfiles/zshrc" "$HOME/.zshrc"
ln -sf "$HOME/dotfiles/config.yaml" "$clangd_dir/config.yaml"

echo "done"
echo "Setup completed successfully!"
