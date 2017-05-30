#!/bin/bash
#
####################################################
####################################################
###########      Current Version 1.0      ##########
###########                               ##########
###########   created by - Thomas Cosby   ##########
###########           2017 05 29          ##########
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
###########          Version 1.0          ##########
###########                               ##########
####################################################
####################################################
####################################################
#  Version History
#
##########################################################################################
#  This script removes default items from the dock and adds BR SF
#+ spare dock items
#
##########################################################################################
#  Requires docutil installed in /usr/bin/local/
#
##########################################################################################
#  docutil Information
#
#  Developer: Kyle Crawford
#+ https://www.jamf.com/jamf-nation/third-party-products/developers/100/kyle-crawford
#  Current Version: 2.0.5
#  Product URL: https://github.com/kcrawford/dockutil/
#  Download: https://github.com/kcrawford/dockutil/tree/2.0.5
#
##########################################################################################
#  Usage
#
#   dockutil -h
#   dockutil --add <path to item> | <url> [--label <label>] [ folder_options ] [ position_options ] [--no-restart] [ plist_location_specification ]
#   dockutil --remove <dock item label> | <app bundle id> | all | spacer-tiles [--no-restart] [ plist_location_specification ]
#   dockutil --move <dock item label>  position_options [ plist_location_specification ]
#   dockutil --find <dock item label> [ plist_location_specification ]
#   dockutil --list [ plist_location_specification ]
#   dockutil --version
#
#  position_options:
#   --replacing <dock item label name>                      replaces the item with the given dock label or adds the item to the end if item to replace is not found
#   --position [ index_number | beginning | end | middle ]  inserts the item at a fixed position: can be an position by index number or keyword
#   --after <dock item label name>                          inserts the item immediately after the given dock label or at the end if the item is not found
#   --before <dock item label name>                         inserts the item immediately before the given dock label or at the end if the item is not found
#   --section [ apps | others ]                             specifies whether the item should be added to the apps or others section
#
#  plist_location_specifications:
#   <path to a specific plist>                              default is the dock plist for current user
#   <path to a home directory>
#       --allhomes                                          attempts to locate all home directories and perform the operation on each of them
#       --homeloc                                           overrides the default /Users location for home directories
#
#  folder_options:
#   --view [grid|fan|list|auto]                             stack view option
#   --display [folder|stack]                                how to display a folder's icon
#   --sort [name|dateadded|datemodified|datecreated|kind]   sets sorting option for a folder view
#
##########################################################################################
#
#  Variables
REMOVE=/usr/bin/local/dockutil --remove
ADD=/usr/bin/local/dockutil --add
MOVE=/usr/bin/local/docutil --move
#
##########################################################################################


$REMOVE 'Mail' --allhomes
$REMOVE 'Launchpad' --allhomes
$REMOVE 'Siri' --allhomes
$REMOVE 'System Preferences' --allhomes
$REMOVE 'Contacts' --allhomes
$REMOVE 'Calendar' --allhomes
$REMOVE 'Notes' --allhomes
$REMOVE 'Reminders' --allhomes
$REMOVE 'Maps' --allhomes
$REMOVE 'Photos' --allhomes
$REMOVE 'Messages' --allhomes
$REMOVE 'Safari' --allhomes
$REMOVE 'FaceTime' --allhomes
$REMOVE 'iBooks' --allhomes
$REMOVE 'App Store' --allhomes
$ADD /Applications/Google\ Chrome.app --label 'Chrome' --positon 1  --allhomes
$ADD /Applications/Slack.app --position 2 --allhomes
$ADD /Applications/Keynote.app --position 3 --allhomes


exit 0
#  A zero return value from the script upon exit indicates success
#+ to the shell.