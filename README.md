
# Description

This is an example of using [fastlane](https://fastlane.tools) with Jenkins 2 and it's pipeline-as-code plugin.

The pipeline as 4 stages, each defined as it's own lane in `fastlane` and is designed to deploy test apps to [HockeyApp](https://www.hockeyapp.net/features/).

More information on what each stage does can be found in the `Readme.md` under the `fastlane` directory.

# Usage

Put the `fastlane` and `pipeline` folders in this repo into your project root directory. Move your `xcodeproj`, `xcworkspace` and code directories into a subdirectory called `src`. The directory strucure should look like this:

```
<project-root>/
├── fastlane/
│   ├── Fastfile
│   ├── .env.default
│   ├── .env.production
│   ├── .swiftlint.yml
│   └── Readme.md
├── pipelines/
│   └── Jenkinsfile
└── src/
    ├── *.xcodeproj
    ├── *.xcworkspace
    ├── SomeFolderWithCode/
    └── SomeFolderWithTests/

```

Set your project params in `.env.default`. Further docs on how this is leveraged is found in the readme in the `fastlane` directory.

Set up your build server using the `setup-ios-build-server.sh` script.

Set up Jenkins as per your requirements. There are a variety of guides available on the internet. [This](http://www.cimgf.com/2015/05/26/setting-up-jenkins-ci-on-a-mac-2/) is the one I used. I also set up Nginx as a reverse proxy to make Jenkins accessible on port 80.

Follow the Jenkins 2 pipeline-as-code plugin docs and point it to the `Jenkinsfile` under the `pipelines` directory.

# SwiftLint

The `lint` lane does produce a SwiftLint report but it's in plain text and not very readable. Other formats produced by SwiftLint are meant to be machine readable by tools such as Sonar which are complete rubbish and a pain to set up.

Hence, It's better to integrate SwiftLint with Xcode so it's easier to track issues. Create a "Run Script" build phase in your Xcode project and copy the following in:

```
if which swiftlint >/dev/null; then
    cd ..
    cp fastlane/.swiftlint.yml src/.swiftlint.yml

    swiftlint
else
    echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
fi
```

## License

This project is available under the MIT license. See the LICENSE.md file for more info.


## Feedback and Questions

Email me if you run into any trouble or have any feedback!

[ayush.newatia@icloud.com](mailto:ayush.newatia@icloud.com)