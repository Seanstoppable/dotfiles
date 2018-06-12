#!/usr/bin/env sh

#show all files in finder
defaults write com.apple.finder AppleShowAllFiles YES
killall Finder

#disable guest account selection
sudo defaults write /Library/Preferences/com.apple.loginwindow GuestEnabled -bool FALSE

#disable IR Controller
echo "Prompt to disable IR Controller"
sudo defaults write /Library/Preferences/com.apple.driver.AppleIRController DeviceEnabled -bool false

#install command line devtools
xcode-select --install
