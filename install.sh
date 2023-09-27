#!/bin/bash

dotfile_directory="$HOME/dotfiles"
install_choices=(
  "Install everything automatically"
  "Install interactive"
  "Install only one"
)
files=(
  ".bash_profile"
  ".gitconfig"
  ".tmux.conf"
  ".vimrc"
  ".zprofile"
  ".zshrc"
)
function check_cmd() {
  if ! command -v $1 >/dev/null 2>&1; then
    echo "Need $1 installed"
    exit 1
  fi
}
function green_text() {
  str="$1"
  echo -e -n "\033[32m$str"
  echo -e -n "\033[0m"
  echo
}

# Check git
check_cmd git

# Get dotfiles
git clone https://github.com/vinmaster/dotfiles.git $dotfile_directory

# Chose install method
green_text "Installing dotfiles"
echo "------------------------------------"
for (( i=1; i<${#install_choices[@]}+1; i++ )); do
  echo "$i ) ${install_choices[$i-1]}"
done

read -p "Choose one: " choice
green_text "Selected $choice. ${install_choices[$choice-1]}"
echo

# Chose install method
if [ $choice -ne 3 ]; then
  for file in ${files[@]}; do
    yesno="y"
    # Check if interactive
    if [ $choice -eq 2 ]; then
      read -p "Install $file? (y/n) " yesno
    fi

    if [ "$yesno" != "n" ]; then
      echo "ln -fns $dotfile_directory/$file ~/$file"
      ln -fns $dotfile_directory/$file ~/$file
    fi
  done
else
  for (( i=1; i<${#files[@]}+1; i++ )); do
    echo "$i ) ${files[$i-1]}"
  done
  read -p "Choose one: " index
  file=${files[$index-1]}
  echo "ln -fns $dotfile_directory/$file ~/$file"
  ln -fns $dotfile_directory/$file ~/$file
fi
echo

green_text "Done. Reload your terminal"
unset check_cmd
unset green_text

exit 0

