#!/usr/bin/env sh

BIN_FOLDER=~/.bin

#Backup of old files
for file in ~/.vim ~/.vimrc ~/.tmux.conf
do
	if [ -h file ]; then
		echo "backup for: $file"
		mv file "$file.`date +%s`.bak" 
	fi
done

#Linking
ln -s `pwd`/vim ~/.vim
ln -s `pwd`/vimrc ~/.vimrc
ln -s `pwd`/tmux.conf ~/.tmux.conf
