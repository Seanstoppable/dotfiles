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

# Disable automatic keyboard backlight
defaults write com.apple.BezelServices kDim -bool false

# Turn off backlight after interval of inactivity
defaults write com.apple.BezelServices kDimTime -int 1
