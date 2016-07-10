fastlane documentation
================
# Installation
```
sudo gem install fastlane
```
# Available Actions
### lint
```
fastlane lint
```
Does a static analysis of the project. Configure the options in .swiftlint.yml
### test
```
fastlane test
```
Runs all the unit tests and UI Tests

Configure the .env.default file in this directory before you run the test or build lanes.

Info on the .env files and how to use them can be found here: https://github.com/fastlane/fastlane/blob/master/fastlane/docs/Advanced.md#environment-variables

### build
```
fastlane build
```
Builds the project and produces an .ipa. Pass in the build_numer and version_number as params. Defaults are 1 and 1.0.0 respectively.

Docs on how to pass in parameters are here: https://github.com/fastlane/fastlane/blob/master/fastlane/docs/Advanced.md#passing-parameters
### deploy
```
fastlane deploy
```
Deploys the built IPA and symbols on HockeyApp

----

This README.md is auto-generated and will be re-generated every time to run [fastlane](https://fastlane.tools).
More information about fastlane can be found on [https://fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [GitHub](https://github.com/fastlane/fastlane/tree/master/fastlane).