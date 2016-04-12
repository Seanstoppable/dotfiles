#!/bin/bash

####
# List available updates from Homebrew (OS X)
###

exit_with_error() {
  echo "err | color=red";
  exit 1;
}

/usr/local/bin/brew update > /dev/null || exit_with_error;

PINNED=$(/usr/local/bin/brew list --pinned);
OUTDATED=$(/usr/local/bin/brew outdated --quiet);

#UPDATES=$(/usr/local/bin/brew outdated --verbose);
UPDATES=$(comm -13 <(for X in "${PINNED[@]}"; do echo "${X}"; done) <(for X in "${OUTDATED[@]}"; do echo "${X}"; done))


UPDATE_COUNT=$(echo "$UPDATES" | grep -c '[^[:space:]]');

echo "↑$UPDATE_COUNT | dropdown=false"
echo "---";
if [ -n "$UPDATES" ]; then
  echo "Upgrade all | bash=/usr/local/bin/brew param1=upgrade"
  echo "$UPDATES | refresh=true" | awk '{print $0 " | bash=/usr/local/bin/brew param1=upgrade param2=" $1 }'
fi
