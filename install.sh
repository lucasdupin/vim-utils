#!/usr/bin/env sh

BIN_FOLDER=~/.bin

#Backup of old files
for file in ~/.vim ~/.vimrc ~/.ctags ~/.tmux.conf
do
	if [ -h file ]; then
		echo "backup for: $file"
		mv file "$file.`date +%s`.bak" 
	fi
done

#Linking
ln -s `pwd`/vim ~/.vim
ln -s `pwd`/vimrc ~/.vimrc
ln -s `pwd`/ctags ~/.ctags
ln -s `pwd`/tmux.conf ~/.tmux.conf
ln -s `pwd`/gitconfig ~/.gitconfig

#Installing daemon
if [ -d $BIN_FOLDER ]; then
	echo ".bin already exists"
else
	#Creating dir
	mkdir $BIN_FOLDER
	#exporting to path
	echo "export PATH=$BIN_FOLDER:\$PATH" >> ~/.bash_profile

	#sourcing
	source ~/.bash_profile
fi

echo "Yep!"
