#!/usr/bin/env sh

# Show all files in finder
defaults write com.apple.finder AppleShowAllFiles YES
killall Finder

# Disable guest account selection
sudo defaults write /Library/Preferences/com.apple.loginwindow GuestEnabled -bool FALSE

# Disable IR Controller
echo "Prompt to disable IR Controller"
sudo defaults write /Library/Preferences/com.apple.driver.AppleIRController DeviceEnabled -bool false

# Install command line devtools
xcode-select --install

# Disable autocorrect
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false
