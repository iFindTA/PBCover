Pod::Spec.new do |s|

  s.name         = "PBCover"
  s.version      = "1.1.0"
  s.summary      = "transition cover module for iOS development."
  s.description  = "transition cover module for FLK.Inc iOS Developers, such as sign in/sign up etc."

  s.homepage     = "https://github.com/iFindTA"
  s.license      = "MIT (LICENSE)"
  s.author             = { "nanhujiaju" => "hujiaju@hzflk.com" }

  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/iFindTA/PBCover.git", :tag => "#{s.version}" }
  s.source_files  = "PBCover/Pod/Classes/*.{h,m}"
  s.public_header_files = "PBCover/Pod/Classes/*.h"

  s.resources    = "PBCover/Pod/Assets/*.*"

  #s.libraries    = "CommonCrypto"
  s.frameworks  = "UIKit","Foundation","SystemConfiguration"
  # s.frameworks = "SomeFramework", "AnotherFramework"

  s.requires_arc = true

  #s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/CommonCrypto,$(SRCROOT)/FLKNetService/Core","CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES" =>"YES","ONLY_ACTIVE_ARCH" => "NO"}
  
  #s.dependency "JSONKit", "~> 1.4"
  s.dependency 'Masonry'
  s.dependency 'FLKBaseClasses'
end