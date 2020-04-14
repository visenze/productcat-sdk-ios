#
#  Be sure to run `pod spec lint ViSearchSwift.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  
  s.name         = "ProductCat"
  s.version      = "0.1.1"
  s.summary      = "ProductCat API"

  s.description  = <<-DESC
                    ProductCat (Products Catalog Platform) API enables you to find and 
                    search for your products more easily by cataloguing your products automatically
                   DESC

  s.homepage     = "https://github.com/visenze/productcat-sdk-ios"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

  s.license          = {:type => "MIT", :file => "LICENSE"}
 
  s.author             = { "Ngo Hung" => "hung@visenze.com" }
 
  s.source = { :git => 'https://github.com/visenze/productcat-sdk-ios.git', :tag => s.version }
  
  s.ios.deployment_target = '10.0'


  s.source_files  = "ProductCat/ProductCat/**/*.{h,swift}"
  s.resources  = ["ProductCat/ProductCat/Classes/PrivacyPolicy/ProductCatPrivacyFlow.storyboard"]
  
  #s.exclude_files = "Classes/Exclude"

  # s.public_header_files = "Classes/**/*.h"


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

  # s.framework  = "SomeFramework"
  # s.frameworks = "SomeFramework", "AnotherFramework"

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"
  s.swift_versions = ['5.1', '5.2']
 
end
