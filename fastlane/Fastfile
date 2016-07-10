default_platform :ios

before_all do
	sh 'mkdir ../reports || true'
	sh 'mkdir ../dist || true'
end

# Fastlane runs all built in actions from one directory above where the Fastfile lives 
# so make sure all the paths are relative in that regard.

desc "Does a static analysis of the project. Configure the options in .swiftlint.yml"
lane :lint do
	swiftlint(
		mode: :lint,
		output_file: 'reports/swiftlint.txt',
 		config_file: 'fastlane/.swiftlint.yml'
	)
end

desc "Runs all the unit tests and UI Tests"
desc "Configure the .env.default file in this directory before you run the test or build lanes."
desc "Info on the .env files and how to use them can be found here: https://github.com/fastlane/fastlane/blob/master/fastlane/docs/Advanced.md#environment-variables"
lane :test do
	# Run tests
	test_args = {
		scheme: ENV["SCHEME"],
		clean: true,
		code_coverage: true,
		output_types: "html, junit",
		output_directory: "reports"		
	}
	if ENV["WORKSPACE"]
		test_args[:workspace] = "src/" + ENV["WORKSPACE"]
	else
		test_args[:project] = "src/" + ENV["PROJECT"]
	end

	scan(test_args)

	# Generate code coverage report
	code_cov_args = {
		scheme: ENV["SCHEME"],
		proj: "src/" + ENV["PROJECT"],
		cobertura_xml: true,
		output_directory: "reports/"
	}
	if ENV["WORKSPACE"]
		code_cov_args[:workspace] = "src/" + ENV["WORKSPACE"]
	end

	slather(code_cov_args)
end

desc "Builds the project and produces an .ipa. Pass in the build_number as a param. Default is 1."
desc "Docs on how to pass in parameters are here: https://github.com/fastlane/fastlane/blob/master/fastlane/docs/Advanced.md#passing-parameters"
lane :build do |options|
	# Set default build number for local builds
	build_number = "1"

	# Read in value in case the user has specified input params
	if options[:build_number]
		build_number = options[:build_number]
	end

	increment_build_number(
  		build_number: build_number,
  		xcodeproj: "src/" + ENV["PROJECT"]
	)

	increment_version_number(
 		version_number: ENV["VERSION"],
  		xcodeproj: "src/" + ENV["PROJECT"]
	)

	# Build additional args to xcodebuild
	xcodeargs = "PRODUCT_BUNDLE_IDENTIFIER=" + ENV["BUNDLE_ID"]
	if ENV["PROVISIONING_PROFILE"]
		xcodeargs = xcodeargs + " " + "PROVISIONING_PROFILE=" + ENV["PROVISIONING_PROFILE"]
	end

	args = {
		scheme: ENV["SCHEME"],
		clean: true,
		output_directory: "dist/",
		output_name: ENV["PRODUCT_NAME"].dup, # Fastlane probably modifies this string under the hood, so the .dup is needed to make it mutable.
		codesigning_identity: ENV["CERTIFICATE"],
		xcargs: xcodeargs,
		use_legacy_build_api: true # There are issues with the build if this isn't set. Try removing on Xcode 8 and see if it works.
	}

	if ENV["WORKSPACE"]
		args[:workspace] = "src/" + ENV["WORKSPACE"]
	else
		args[:project] = "src/" + ENV["PROJECT"]
	end

	gym(args)
end

desc "Deploys the built IPA and symbols on HockeyApp"
lane :deploy do
	hockey(
		api_token: ENV["HOCKEY_API_TOKEN"],
		public_identifier: ENV["HOCKEY_APP_ID"],
		ipa: "dist/" + ENV["PRODUCT_NAME"] + ".ipa",
		dsym: "dist/" + ENV["PRODUCT_NAME"] + ".app.dSYM.zip",
	)
end