#!/bin/sh

# TODO: add try blocks and fail checks to this script; add set -xe?
echo "Checking for config directory... \c"
if [ ! -d "$HOME/.config" ]
then
  mkdir "$HOME/.config"
  echo "done -> created missing $HOME/.config"
else
  echo "found $HOME/.config"
fi

echo "Checking for vim directory... \c"
if [ ! -d "$HOME/.vim" ]
then
  mkdir "$HOME/.vim"
  echo "done -> created missing $HOME/.vim"
else
  echo "found $HOME/.vim"
fi

echo "Checking for mpv directory... \c"
if [ ! -d "$HOME/.config/mpv" ]
then
  mkdir "$HOME/.config/mpv"
  echo "done -> created missing $HOME/.config/mpv"
else
  echo "found $HOME/.config/mpv"
fi

echo "Checking for nvim directory... \c"
if [ ! -d "$HOME/.config/nvim" ]
then
  mkdir "$HOME/.config/nvim"
  echo "done -> created missing $HOME/.config/nvim"
else
  echo "found $HOME/.config/nvim"
fi

echo "Checking for zathura directory... \c"
if [ ! -d "$HOME/.config/zathura" ]
then
  mkdir "$HOME/.config/zathura"
  echo "done -> created missing $HOME/.config/zathura"
else
  echo "found $HOME/.config/zathura"
fi

echo "Checking for kitty directory... \c"
if [ ! -d "$HOME/.config/kitty" ]
then
  mkdir "$HOME/.config/kitty"
  echo "done -> created missing $HOME/.config/kitty"
else
  echo "found $HOME/.config/kitty"
fi

echo "Checking for alacritty directory... \c"
if [ ! -d "$HOME/.config/alacritty" ]
then
  mkdir "$HOME/.config/alacritty"
  echo "done -> created missing $HOME/.config/alacritty"
else
  echo "found $HOME/.config/alacritty"
fi

echo "Checking for clangd directory... \c"

clangd_dir=""
if [ $(echo "$OSTYPE" | grep -c 'darwin') -gt 0 ]
then
  clangd_dir="$HOME/Library/Preferences/clangd"
else
  clangd_dir="$HOME/.config/clangd"
fi

if [ ! -d $clangd_dir ]
then
  mkdir $clangd_dir
  echo "done -> created missing $clangd_dir"
else
  echo "found $clangd_dir"
fi

echo "Creating symbolic links... \c"
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
echo "Setup completed successfuly!"
