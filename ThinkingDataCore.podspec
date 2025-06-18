#
# Be sure to run `pod lib lint ThinkingDataCore.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ThinkingDataCore'
  s.version          = '1.3.1'
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
  s.source           = { :git => 'https://github.com/ThinkingDataAnalytics/ThinkingDataCore-iOS-SDK.git', :tag => "v#{s.version}" }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  s.requires_arc     = true

  s.default_subspec = 'Main'
  s.ios.deployment_target = '9.0'
  s.osx.deployment_target = '10.11'
  s.watchos.deployment_target = "6.0"
  s.tvos.deployment_target = "13.0"
  s.visionos.deployment_target = "1.0"
  
  s.subspec 'iOS' do |i|
    i.ios.deployment_target = '9.0'
    path = 'ThinkingDataCore/Classes'
    i.source_files = path + '/**/*'
  end
  
  s.subspec 'OSX' do |o|
    o.osx.deployment_target = '10.11'
    path = 'ThinkingDataCore/Classes'
    o.source_files = path + '/**/*'
    o.exclude_files = path + '/DeviceInfo/TDCoreFPSMonitor.{h,m}', path + '/Network/TDNetworkReachability.{h,m}', path + '/Store/TDStorageEncryptPlugin.{h,m}', path + '/Encrypt/*.{h,m}'
  end

  s.subspec 'watchOS' do |o|
    o.watchos.deployment_target = "6.0"
    path = 'ThinkingDataCore/Classes'
    o.source_files = path + '/**/*'
    o.exclude_files = path + '/DeviceInfo/TDCoreFPSMonitor.{h,m}', path + '/Network/TDNetworkReachability.{h,m}', path + '/Store/TDStorageEncryptPlugin.{h,m}', path + '/Encrypt/*.{h,m}'
  end

  s.subspec 'tvOS' do |o|
    o.tvos.deployment_target = "13.0"
    path = 'ThinkingDataCore/Classes'
    o.source_files = path + '/**/*'
    o.exclude_files = path + '/DeviceInfo/TDCoreFPSMonitor.{h,m}', path + '/Network/TDNetworkReachability.{h,m}', path + '/Store/TDStorageEncryptPlugin.{h,m}', path + '/Encrypt/*.{h,m}'
  end

  s.subspec 'versionOS' do |o|
    o.visionos.deployment_target = "1.0"
    path = 'ThinkingDataCore/Classes'
    o.source_files = path + '/**/*'
    o.exclude_files = path + '/DeviceInfo/TDCoreFPSMonitor.{h,m}', path + '/Network/TDNetworkReachability.{h,m}', path + '/Store/TDStorageEncryptPlugin.{h,m}', path + '/Encrypt/*.{h,m}'
  end
  
  s.subspec 'Main' do |m|
    m.ios.dependency 'ThinkingDataCore/iOS'
    m.osx.dependency 'ThinkingDataCore/OSX'
    m.tvos.dependency 'ThinkingDataCore/tvOS'
    m.watchos.dependency 'ThinkingDataCore/watchOS'
    m.visionos.dependency 'ThinkingDataCore/versionOS'
  end

  s.resource_bundles = {'ThinkingDataCore' => ['ThinkingDataCore/Resources/**/*']}
  
end
