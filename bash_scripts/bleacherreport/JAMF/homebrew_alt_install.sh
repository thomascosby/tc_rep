#!/bin/bash
#
####################################################
####################################################
####################################################
###########          Version 1.0          ##########
###########                               ##########31
###########   created by - Thomas Cosby   ##########
###########           2018 02 28          ##########
###########          __        __         ##########
###########         /\ \   *  /\ \        ##########
###########         \:\ \    /::\ \       ##########
###########          \:\ \  /:/\:\ \      ##########
###########        * /::\ \/:/ /\:\ \     ##########
###########         /:/\:\_\/_/  \:\_\    ##########
###########        /:/ /\/_/\ \   \/_/    ##########
###########       /:/ /    \:\ \  *       ##########
###########       \/_/      \:\ \         ##########
###########               *  \:\_\        ##########
###########                   \/_/        ##########
###########                               ##########
###########      Current Version 1.0      ##########
###########                               ##########
####################################################
####################################################
####################################################
#  Version History
#  
#  
####################################################
#  
#  this script installs  the latest version of
#+ Homebrew
#  
####################################################
#
# Set up variables and functions here
#
####################################################


osascript <<'EOF'
tell application "Terminal"
    activate
    do script ("/usr/bin/ruby -e \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)\"") in window 1
end tell
EOF

exit 0
#  A zero return value from the script upon exit indicates success
#+ to the shell.