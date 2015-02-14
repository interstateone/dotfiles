#!/bin/bash
############################
# install.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dotfiles                              # dotfiles directory
olddir=~/dotfiles_old                       # old dotfiles backup directory
files="zshrc tmux.conf zsh-custom amethyst config gitconfig gitignore_global mpdconf msmtprc mutt ncmpcpp notmuch-config offlineimaprc teamocil tigrc urlview vimperatorrc vimrc weechat" # list of files/folders to symlink in homedir

##########

# install oh-my-zsh
echo "Installing oh-my-zsh"
curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
echo "...done"

# grab the latest from git
echo "Cloning latest version to $dir"
git clone git@github.com:interstateone/dotfiles.git $dir
echo "...done"

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/.$file ~/dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done
