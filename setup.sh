#!/bin/bash
##
## rbenv4ubuntu
## version 0.1
## This Bash script install Ruby on Rails with rbenv on Ubuntu.
## - run as standard user
## - environment is created in the home directory
##

SUDO = which sudo
GIT = which git
RUBY_VERSION = "1.9.3-p362"

echo "Update repositories"
$SUDO aptitude update

echo "Update repositories"
$SUDO apt-get install nodejs sqlite3 libsqlite3-dev zlib1g-dev build-essential libssl-dev libreadline-dev git-core

echo "Clone rbenv"
$GIT clone git://github.com/sstephenson/rbenv.git ~/.rbenv

echo "Setup paths"
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
exec $SHELL

echo "Clone ruby-build"
mkdir -p ~/.rbenv/plugins
cd ~/.rbenv/plugins
$GIT clone git://github.com/sstephenson/ruby-build.git
exec $SHELL

echo "Install Ruby"
rbenv install $RUBY_VERSION
rbenv global $RUBY_VERSION
rbenv versions
rbenv local $RUBY_VERSION
exec $SHELL

echo "Install Rails and Bundler from gem"
cd ~
echo "gem: --no-ri --no-rdoc" > ~/.gemrc
gem install bundler
gem install rails

echo "Finish"
