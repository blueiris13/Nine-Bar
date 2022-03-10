# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
flipperkit_version = '0.137.0'

target 'Nine Bar' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Nine Bar
  pod 'Alamofire', '~> 5.5.0'

  pod 'Kingfisher', '~> 7.0'

  # Flipper
  pod 'FlipperKit', '~>' + flipperkit_version, :configuration => 'Debug'
  pod 'FlipperKit/FlipperKitLayoutComponentKitSupport', '~>' + flipperkit_version, :configuration => 'Debug'
  pod 'FlipperKit/SKIOSNetworkPlugin', '~>' + flipperkit_version, :configuration => 'Debug'
  pod 'FlipperKit/FlipperKitUserDefaultsPlugin', '~>' + flipperkit_version, :configuration => 'Debug'
  # ...unfortunately at this time that means you'll need to explicitly mark
  # transitive dependencies as being for debug build only as well:
  pod 'Flipper-DoubleConversion', :configuration => 'Debug'
  pod 'Flipper-Folly', :configuration => 'Debug'
  pod 'Flipper-Glog', :configuration => 'Debug'
  pod 'Flipper-PeerTalk', :configuration => 'Debug'
  pod 'CocoaLibEvent', :configuration => 'Debug'
  pod 'boost-for-react-native', :configuration => 'Debug'
  pod 'OpenSSL-Universal', :configuration => 'Debug'
  pod 'CocoaAsyncSocket', :configuration => 'Debug'
  
  # Flipper - plugins
  pod 'FlipperKit/SKIOSNetworkPlugin', '~>' + flipperkit_version
  
  # NOTE Doing this may lead to a broken build if any of these are also
  #      transitive dependencies of other dependencies and are expected
  #      to be built as frameworks.
  #
  $static_framework = ['FlipperKit', 'Flipper', 'Flipper-Folly',
    'CocoaAsyncSocket', 'ComponentKit', 'Flipper-DoubleConversion',
    'Flipper-Glog', 'Flipper-PeerTalk', 'Flipper-RSocket', 'Yoga', 'YogaKit',
    'CocoaLibEvent', 'OpenSSL-Universal', 'boost-for-react-native', 'Flipper-Fmt']
  #
  pre_install do |installer|
    installer.pods_project&.targets&.each do |target|
      target.build_configurations.each do |config|
        config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
      end
    end
    Pod::Installer::Xcode::TargetValidator.send(:define_method, :verify_no_static_framework_transitive_dependencies) {}
    installer.pod_targets.each do |target|
        if $static_framework.include?(target.name)
          def target.build_type;
            Pod::BuildType.static_library
        end
      end
    end
  end
end
