Pod::Spec.new do |s|
  s.name             = 'ApiRouter'
  s.version          = '0.0.3'
  s.summary          = 'An easy way to control request routing'
  s.homepage         = 'https://github.com/muzle/SwiftNetworkApiRouter'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'muzle' => 'evgrud@icloud.com' }
  s.source           = { :git => 'https://github.com/muzle/SwiftNetworkApiRouter.git', :tag => s.version.to_s }
  s.social_media_url = 'https://www.linkedin.com/in/voragomod'
  s.ios.deployment_target = '10.0'
  s.source_files = 'NetworkApiRouter/Source/**/*'
end
