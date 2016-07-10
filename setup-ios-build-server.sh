#!/bin/bash

# Install Xcode, Xcode Command Line Tools, Apple Certificates and Provisioning profiles on the build server. Then run this script.
# This has been designed for Swift Projects.
# You will need a CI system in addition to these tools.

gem update --system

# Install Homebrew

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install SwiftLint

brew install swiftlint

# Install Fastlane

gem install fastlane

# Install slather for code coverage

gem install slather