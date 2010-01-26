#!/usr/bin/env sh

BIN_FOLDER=~/.bin

#Baking up old files
if [ -h ~/.vim ]; then
	echo "baking up your .vim folder"
	mv ~/.vim ~/vim_bak 
fi

if [ -h ~/.vimrc ]; then
	echo "baking up your .vimrc"
	mv ~/.vimrc ~/vimrc_bak
fi

#Linking
ln -s `pwd`/vim ~/.vim
ln -s `pwd`/vimrc ~/.vimrc

#Installing daemon
if [ -d $BIN_FOLDER ]; then
	echo ".bin already exists"

	#removing old files
	rm $BIN_FOLDER/fcshd.rb
	rm $BIN_FOLDER/mvim
else
	#Creating dir
	mkdir $BIN_FOLDER
	#exporting to path
	echo "export PATH=$BIN_FOLDER:\$PATH" >> ~/.profile

	#sourcing
	source ~/.profile
fi

#Creating the links
ln -s `pwd`/bin/fcshd.rb $BIN_FOLDER/fcshd.rb
ln -s `pwd`/bin/mvim $BIN_FOLDER/mvim

chmod u+x $BIN_FOLDER/fcshd.rb
chmod u+x $BIN_FOLDER/mvim

echo "Yep!"
