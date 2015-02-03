Pod::Spec.new do |s|
  s.name         = "KHSwipeCell"
  s.version      = "0.2.0"
  s.summary      = "An easy-to-use UITableViewCell subclass that implements a swipeable content view"
  s.homepage     = "https://github.com/weekwood/KHSwipeCell"
  s.screenshots  = "https://raw.githubusercontent.com/weekwood/KHSwipeCell/master/gif/KHSwipeCell.gif"
  s.license      = "MIT"
  s.author       =  "Khan.Lau"
  s.platform     = :ios, '5.1'
  s.source       = { :git => "https://github.com/weekwood/KHSwipeCell.git",:tag =>s.version.to_s}
  s.source_files  = "KHSwipeCell/*.{h,m}"
  s.requires_arc = true
end
