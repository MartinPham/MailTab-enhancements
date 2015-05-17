#!/bin/bash

defaults write com.fiplab.mailtabpro WebKitDeveloperExtras TRUE

defaults write com.fiplab.mailtabpro IncludeDebugMenu 1

/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -v -f /Applications/MailTab.app

gcc -framework AppKit -framework Foundation -o MailTabPatch.dylib -dynamiclib MailTabPatch.m
killall MailTab\ Pro\ for\ Gmail
DYLD_INSERT_LIBRARIES=/Applications/MailTab.app/Contents/MailTabPatch/MailTabPatch.dylib /Applications/MailTab.app/Contents/MacOS/MailTab\ Pro\ for\ Gmail &



#codesign -f -s OSXApp /path/to/application
#codesign -dvvvv /path/to/application