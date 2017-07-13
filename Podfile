source 'https://github.com/CocoaPods/Specs'

platform :ios, '8.0'
use_frameworks!
inhibit_all_warnings!

abstract_target 'iostestCommon' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  pod 'RxSwift',               '~> 3.4'
  pod 'RxCocoa',               '~> 3.4'
  pod 'RxDataSources',         '~> 1.0'
  pod 'NSObject+Rx',           '2.0.0'
  pod 'RxSwiftExt',            '~> 2.0'

  pod 'SwiftyColor'

  pod 'SwiftLint'

  pod 'R.swift'
  pod 'SnapKit'
  pod 'Presentr',              '~> 1.1'

  pod 'LKTabBarController'

  target 'iostest' do end
  # Pods for iostest

end


# Copy acknowledgements to the Settings.bundle

post_install do | installer |
    require 'fileutils'

    pods_acknowledgements_path = 'Pods/Target Support Files/Pods/Pods-Acknowledgements.plist'
    settings_bundle_path = Dir.glob("**/*Settings.bundle*").first

    if File.file?(pods_acknowledgements_path)
        puts 'Copying acknowledgements to Settings.bundle'
        FileUtils.cp_r(pods_acknowledgements_path, "#{settings_bundle_path}/Acknowledgements.plist", :remove_destination => true)
    end

    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
