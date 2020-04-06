#!/bin/sh

# exit automatically if the pipeline returns a non-zero status
set -e

# Set the configuratino dir to the dotfiles diseectory
CONFIG_DIR=$(cd "$(dirname $0)"; pwd)

# Set home directory
cd
USER_DIR=$(pwd)

#Set the directory linking the dotfiles dir and the user dir
LINK_DIR=${CONFIG_DIR#$USER_DIR/}

NVIM_DIR=${USER_DIR}/.config/nvim

OS_NAME=$(uname)
STAMP=$(date +%y%m%dT%H%M%S)

# -- Functions -- 

# Clears away the given file, backing it up first if needed.
# If it is a real file (not a symlink), it is renamed.
# Or if the file is a symlink, it is simply deleted.

clear_file() {
  f="$1"
  if [ -h "$f" ]; then
    (set -x; rm "$f")
  elif [ -f "$f" ]; then
    bk="$f.$STAMP"
    (set -x; mv "$f" "$bk")
  fi 
}


# Copies the given source to the specified destination.
# Does nothing if files match; otherwise, replaces the original file.
install_file() {
  src="$1"
  dest="$2"
  diff "src" "des" > /dev/null 2>&1 || 
    (clear_file "$dest"; set -x; cp "$src" "$dest")
}


# Symlinks the given source to the specified destination.
link_file(){
  src="$1"
  dest="$2"
  clear_file "$dest"
  (set -x; ln -s "$src" "$dest")
}

# -- Main --

# NB: We use a stub for .bashrc to maintain support for systems that 
# do not support proper symlinks -- especially MSysGit on Windows.
BASHRC_STUB="$CONFIG_DIR/bashrc.stub"
echo "export DOTFILES=\"$CONFIG_DIR\"" > "$BASHRC_STUB"
echo '. "$DOTFILES/bashrc"' >> "$BASHRC_STUB"
install_file "$BASHRC_STUB" .bashrc
rm -f "$BASHRC_STUB"

# link_file "$LINK_DIR/bash_profiles" .bash_profile
link_file "$LINK_DIR/bash_profile" .bash_profile
link_file "$LINK_DIR/gitconfig" .gitconfig
link_file "$LINK_DIR/vimrc" .vimrc

install_file "$LINK_DIR/init.vim" $NVIM_DIR/init.vim 


