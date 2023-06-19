#!/bin/sh

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

echo "Creating symbolic links... \c"
ln -sf "$HOME/configs/mpv.conf" "$HOME/.config/mpv/mpv.conf"
ln -sf "$HOME/configs/zathurarc" "$HOME/.config/zathura/zathurarc"
ln -sf "$HOME/configs/gitconfig" "$HOME/.gitconfig"
ln -sf "$HOME/configs/tmux.conf" "$HOME/.tmux.conf"
ln -sf "$HOME/configs/colors/" "$HOME/.vim/colors"
ln -sf "$HOME/configs/vimrc" "$HOME/.vimrc"
ln -sf "$HOME/configs/vimrc" "$HOME/.ideavimrc"
ln -sf "$HOME/configs/zshrc" "$HOME/.zshrc"
echo "done."
echo "\nTask completed successfuly!"
