#
# Be sure to run `pod lib lint ThinkingDataCore.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ThinkingDataCore'
  s.version          = '1.0.0'
  s.summary          = 'A short description of ThinkingDataCore.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/ThinkingDataAnalytics/ThinkingDataCore-iOS-SDK'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'Apache License', :file => 'LICENSE' }
  s.author           = { 'ThinkingData, Inc' => 'sdk@thinkingdata.cn' }
  s.source           = { :git => 'https://github.com/ThinkingDataAnalytics/ThinkingDataCore-iOS-SDK.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  s.requires_arc     = true

  s.ios.deployment_target = '9.0'
  s.osx.deployment_target = '10.11'
  
  s.default_subspec = 'Main'
  
  s.subspec 'iOS' do |i|
    i.ios.deployment_target = '9.0'
    i.source_files = 'ThinkingDataCore/Classes/**/*'
  end
  
  s.subspec 'OSX' do |o|
    o.osx.deployment_target = '10.11'
    path = 'ThinkingDataCore/Classes'
    o.source_files = path + '/**/*'
    o.exclude_files = path + '/Router/**/*'
  end
  
  s.subspec 'Main' do |m|
    m.ios.dependency 'ThinkingDataCore/iOS'
    m.osx.dependency 'ThinkingDataCore/OSX'
  end
  
end
