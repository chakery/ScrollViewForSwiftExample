

Pod::Spec.new do |s|

  s.name         = “CGYScrollView”
  s.version      = "0.0.1"
  s.summary      = "A short description of Utility."

  s.description  = <<-DESC
                   DESC

  s.homepage     = "https://github.com/Chakery/ScrollViewForSwiftExample"

  s.license      = "MIT (example)"

  s.author             = { "chakery" => "chakery@sina.com" }

  s.platform     = :ios

  s.source       = { :git => "https://github.com/Chakery/ScrollViewForSwiftExample.git", :tag => "0.0.1" }

  s.source_files  = "Classes", "Classes/**/*.{h,m}"
  s.exclude_files = "Classes/Exclude"

 s.requires_arc = true

 s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
 s.dependency "CGYScrollView"

end
