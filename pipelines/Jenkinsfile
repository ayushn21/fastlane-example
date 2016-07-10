node {
	stage 'Checkout and Setup'
		checkout scm
		sh 'cd fastlane'
	stage 'Lint'
		sh 'fastlane lint'
	stage 'Test'
		sh 'fastlane test'
	stage 'Build'
		def build_number = env.BUILD_NUMBER
		sh "fastlane build build_number:${build_number}"
	stage 'Deploy'
		archive 'reports/, dist/'
		sh 'fastlane deploy'
}