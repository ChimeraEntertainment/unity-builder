#!/usr/bin/env bash

#
# Create directories for license activation
#

sudo mkdir -p /Library/Application\ Support/Unity/config
sudo chmod -R 777 /Library/Application\ Support/Unity

ACTIVATE_LICENSE_PATH="$ACTION_FOLDER/BlankProject"
mkdir -p "$ACTIVATE_LICENSE_PATH"

#
# Run steps
#

#if clean run clean.sh
#if addressables run build-addressables
# always build.sh
source $ACTION_FOLDER/platforms/mac/steps/activate.sh

if [ -z "$CLEAN_BUILD" ]; 

    source $ACTION_FOLDER/platforms/mac/steps/build-library.sh

elif [ -z "$ADDRESSABLE_BUILD" ];

    source $ACTION_FOLDER/platforms/mac/steps/build-addressable.sh

else
    
    source $ACTION_FOLDER/platforms/mac/steps/build.sh

fi


source $ACTION_FOLDER/platforms/mac/steps/return_license.sh

#
# Remove license activation directory
#

sudo rm -r /Library/Application\ Support/Unity
rm -r "$ACTIVATE_LICENSE_PATH"

#
# Instructions for debugging
#

if [[ $BUILD_EXIT_CODE -gt 0 ]]; then
echo ""
echo "###########################"
echo "#         Failure         #"
echo "###########################"
echo ""
echo "Please note that the exit code is not very descriptive."
echo "Most likely it will not help you solve the issue."
echo ""
echo "To find the reason for failure: please search for errors in the log above."
echo ""
fi;

#
# Exit with code from the build step.
#

exit $BUILD_EXIT_CODE
