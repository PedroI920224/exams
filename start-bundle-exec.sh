#!/bin/bash --login

#set up xvfb
Xvfb -ac :99 -screen 0 1280x1024x16 &

export DISPLAY=:99
export BUNDLE_PATH=./gems

bundle check || bundle install
npm install

#entrypoint for docker
bundle exec "$@"
