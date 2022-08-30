#
# Be sure to run `pod lib lint VoiceRoomBaseUIKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'VoiceRoomBaseUIKit'
  s.version          = '0.1.0'
  s.summary          = 'A short description of VoiceRoomBaseUIKit.'
  
  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  
  s.description      = <<-DESC
  TODO: Add long description of the pod here.
  DESC
  
  s.homepage         = 'https://github.com/zjc19891106/VoiceRoomBaseUIKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zjc19891106' => '984065974@qq.com' }
  s.source           = { :git => 'https://github.com/zjc19891106/VoiceRoomBaseUIKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  
  s.ios.deployment_target = '13.0'
  
  s.subspec 'VoiceRoomScene' do |scene|
    scene.source_files = 'VoiceRoomBaseUIKit/Classes/VoiceRoomScene/**/*'
  end
  s.subspec 'VoiceRoomService' do |service|
    service.source_files = 'VoiceRoomBaseUIKit/Classes/VoiceRoomService/**/*'
    service.dependency 'Agora_Chat_iOS'
  end
  s.subspec 'Commons' do |service|
    service.source_files = 'VoiceRoomBaseUIKit/Classes/Commons/**/*'
  end
  
  s.resource_bundles = {
    'VoiceRoomBaseUIKit' => ['VoiceRoomBaseUIKit/Assets/*']
  }
  s.requires_arc = true
  s.static_framework = true
  s.public_header_files = 'Pod/Classes/**/*'
  s.frameworks = 'UIKit', 'Foundation'
  s.dependency 'ZSwiftBaseLib','0.1.5'
  s.dependency 'VoiceRoomRequest'
end
