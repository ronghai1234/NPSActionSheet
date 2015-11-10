Pod::Spec.new do |s|
  s.name         = "NPSActionSheet"
  s.version      = "1.1"
  s.summary      = "A coustom ActionSheet"
  s.license      = "MIT"
  s.author       = "Ronghai1234"
  s.homepage     = "https://github.com/ronghai1234/NPSActionSheet"
  s.source       = {:git=>"https://github.com/ronghai1234/NPSActionSheet.git",:tag => s.version}
  s.source_files = "NPSActionSheet/*.{h,m}"
  s.requires_arc = true
  s.platform     = :ios, "7.0"
  s.dependency "Masonry", " ~> 0.5.3"
end
