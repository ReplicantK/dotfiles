#!/bin/sh

# TODO: add try blocks and fail checks to this script; add set -xe?
echo "Checking for .config directory... \c"
if [ ! -d "$HOME/.config/" ]
then
  mkdir "$HOME/.config/"
  echo "done -> created missing .config directory in home."
else
  echo "found .config directory in home."
fi

echo "Checking for .vim directory... \c"
if [ ! -d "$HOME/.vim/" ]
then
  mkdir "$HOME/.vim/"
  echo "done -> created missing .vim directory in home."
else
  echo "found .vim directory in home."
fi

echo "Checking for mpv directory... \c"
if [ ! -d "$HOME/.config/mpv/" ]
then
  mkdir "$HOME/.config/mpv"
  echo "done -> created missing mpv directory in .config"
else
  echo "found mpv directory in .config."
fi

echo "Checking for zathura directory... \c"
if [ ! -d "$HOME/.config/zathura/" ]
then
  mkdir "$HOME/.config/zathura/"
  echo "done -> created missing zathura directory in .config"
else
  echo "found zathura directory in .config."
fi

echo "Checking for kitty directory... \c"
if [ ! -d "$HOME/.config/kitty/" ]
then
  mkdir "$HOME/.config/kitty/"
  echo "done -> created missing kitty directory in .config"
else
  echo "found kitty directory in .config."
fi

echo "Checking for alacritty directory... \c"
if [ ! -d "$HOME/.config/alacritty/" ]
then
  mkdir "$HOME/.config/alacritty/"
  echo "done -> created missing alacritty directory in .config"
else
  echo "found alacritty directory in .config."
fi

echo "Creating symbolic links... \c"
ln -sf "$HOME/dotfiles/alacritty.toml" "$HOME/.config/alacritty/alacritty.toml"
ln -sf "$HOME/dotfiles/mpv.conf" "$HOME/.config/mpv/mpv.conf"
ln -sf "$HOME/dotfiles/kitty.conf" "$HOME/.config/kitty/kitty.conf"
ln -sf "$HOME/dotfiles/zathurarc" "$HOME/.config/zathura/zathurarc"
ln -sf "$HOME/dotfiles/gitconfig" "$HOME/.gitconfig"
ln -sf "$HOME/dotfiles/tmux.conf" "$HOME/.tmux.conf"
ln -sf "$HOME/dotfiles/colors/" "$HOME/.vim/colors"
ln -sf "$HOME/dotfiles/vimrc" "$HOME/.vimrc"
ln -sf "$HOME/dotfiles/vimrc" "$HOME/.ideavimrc"
ln -sf "$HOME/dotfiles/zshrc" "$HOME/.zshrc"
echo "done."
echo "\nTask completed successfuly!"
