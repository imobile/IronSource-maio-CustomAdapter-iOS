#
# Be sure to run `pod lib lint IronSourceMaioCustomAdapter.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#
adapter_version = '1.0.0'

Pod::Spec.new do |s|
  s.name             = 'IronSourceMaioCustomAdapter'
  s.version          = adapter_version
  s.summary          = 'Custom adapter for connecting IronSource and Maio.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Custom adapter for connecting IronSource and Maio.
                       DESC

  s.homepage         = 'https://github.com/imobile/IronSource-maio-CustomAdapter-iOS.git'
  s.license          = { :type => 'Apache-2.0', :file => 'LICENSE' }
  s.author           = 'i-mobile'
  s.source           = { :git => 'https://github.com/imobile/IronSource-maio-CustomAdapter-iOS.git', :tag => s.version.to_s }

  s.ios.deployment_target = '12.0'
  s.swift_version    = '5.0'

  s.source_files = 'ISMaioCustomAdapter/ISMaioCustomAdapter/**/*'
  s.static_framework = true

  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'MaioSDK-v2', '>= 2.1.5'
  s.dependency 'IronSourceSDK/Ads', '>= 8.9.0'
end
