#!/usr/bin/env sh


###
# Terminal

# Enable Secure Keyboard Entry in Terminal.app
# See: https://security.stackexchange.com/a/47786/8918
defaults write com.apple.terminal SecureKeyboardEntry -bool true

# Set system hostname
if [ ! -f ~/.hostname ] ; then
  echo "Enter hostname: "
  read -r hostname
  scutil --set HostName "$hostname"
  scutil --set ComputerName "$hostname"
  scutil --set LocalHostName "$hostname"
  echo "$hostname" > ~/.hostname
fi

# Set terminal defaults
# Set theme
defaults write com.apple.terminal "Startup Window Settings" -string "Homebrew"
defaults write com.apple.terminal "Default Window Settings" -string "Homebrew"

# Disable audio bell
/usr/libexec/PlistBuddy -c "Delete 'Window Settings':Homebrew:AudibleBell" ~/Library/Preferences/com.apple.Terminal.plist > /dev/null 2>&1
/usr/libexec/PlistBuddy -c "Add 'Window Settings':Homebrew:AudibleBell bool false" ~/Library/Preferences/com.apple.Terminal.plist

###
# UI/UX

# Use plain text mode for new TextEdit documents
defaults write com.apple.TextEdit RichText -int 0
# Open and save files as UTF-8 in TextEdit
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

# Disable autocorrect
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false

# Disable automatic keyboard backlight
defaults write com.apple.BezelServices kDim -bool false

# Turn off backlight after interval of inactivity
defaults write com.apple.BezelServices kDimTime -int 1

# Write screenshots to Documents folder, making it easier to drag into browser
defaults write com.apple.screencapture location ~/Documents

# Restart UIServer to use updated location

# Show battery percentage
defaults write com.apple.menuextra.battery ShowPercent -bool true

# Disable smart quotes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Hide icons for hard drives, servers, and removable media from the desktop
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowMountedServersOnDesktop -bool false
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false

# Show all files in finder
defaults write com.apple.finder AppleShowAllFiles YES

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

###
# Screen and Screensaver

# Require password 5 seconds after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 5

defaults -currentHost write com.apple.screensaver moduleDict -dict path -string "/System/Library/Frameworks/ScreenSaver.framework/PlugIns/iLifeSlideshows.appex" moduleName -string "iLifeSlideshows" type -int 0

###
# Safari

# Privacy: don’t send search queries to Apple
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

# Warn about fraudulent websites
defaults write com.apple.Safari WarnAboutFraudulentWebsites -bool true

# Disable Java
defaults write com.apple.Safari WebKitJavaEnabled -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabled -bool false

# Block pop-up windows
defaults write com.apple.Safari WebKitJavaScriptCanOpenWindowsAutomatically -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaScriptCanOpenWindowsAutomatically -bool false

# DISABLE “Do Not Track”. Using it makes you more unique
defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool false

###
# Security

# Disable guest account selection
sudo defaults write /Library/Preferences/com.apple.loginwindow GuestEnabled -bool FALSE

# Disable IR Controller
echo "Prompt to disable IR Controller"
sudo defaults write /Library/Preferences/com.apple.driver.AppleIRController DeviceEnabled -bool false

# Turn on firewall
sudo defaults write /Library/Preferences/com.apple.alf globalstate -int 1

# Turn on stealth
sudo defaults write /Library/Preferences/com.apple.alf stealthenabled -int 1

###
# Other

# Install command line devtools
xcode-select -p 1>/dev/null
if [ $? -ne 0 ] ; then
  xcode-select --install
fi

#Enable locate command
sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist

# Restart services for effects
killall Finder
killall SystemUIServer
