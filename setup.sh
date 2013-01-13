#!/bin/bash
##
## rbenv4ubuntu
## This Bash script install Ruby on Rails with rbenv on Ubuntu.
## - run as standard user
## - environment is created in the home directory
##

## variables
VERSION="0.2"
RUBY_VER="1.9.3-p362"

## check
if [ -e ~/.rbenv/ ]; then
  	echo -n "__"
		echo -n "rbenv is already installed."
	else
		echo "      _                     _  _         _                 _         "
		echo "     | |                   | || |       | |               | |        "
		echo " _ __| |__   ___ _ ____   _| || |_ _   _| |__  _   _ _ __ | |_ _   _ "
		echo "| '__| '_ \ / _ \ '_ \ \ / /__   _| | | | '_ \| | | | '_ \| __| | | |"
		echo "| |  | |_) |  __/ | | \ V /   | | | |_| | |_) | |_| | | | | |_| |_| |"
		echo "|_|  |_.__/ \___|_| |_|\_/    |_|  \__,_|_.__/ \__,_|_| |_|\__|\__,_|"
		echo "Installer version $VERSION "
		echo " "
fi

## installator
read -p "Start the installation? Insert 'y' followed by [ENTER]:" validate
if [ $validate = "y" ]; then
		echo "Update repositories."
		echo "__"
		sudo aptitude update

		echo "Update repositories."
		echo "__"
		sudo apt-get install nodejs sqlite3 libsqlite3-dev zlib1g-dev build-essential libssl-dev libreadline-dev git-core

		echo "Clone rbenv."
		echo "__"
		git clone git://github.com/sstephenson/rbenv.git ~/.rbenv

		echo "Setup paths."
		echo "__"
		echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
		echo 'eval "$(rbenv init -)"' >> ~/.bashrc
		exec $SHELL

		echo "Clone ruby-build."
		echo "__"
		mkdir -p ~/.rbenv/plugins
		cd ~/.rbenv/plugins
		git clone git://github.com/sstephenson/ruby-build.git
		exec $SHELL

		echo "Install Ruby."
		echo "__"
		rbenv install $RUBY_VER
		rbenv global $RUBY_VER
		rbenv versions
		rbenv local $RUBY_VER
		exec $SHELL

		echo "Install Rails and Bundler from gem."
		echo "__"
		cd ~
		echo "gem: --no-ri --no-rdoc" > ~/.gemrc
		gem install bundler
		gem install rails

		echo "__"
		echo "Installation is complete ;)"		
	else
		echo "__"
		echo "Installation was canceled."
		exit
fi



