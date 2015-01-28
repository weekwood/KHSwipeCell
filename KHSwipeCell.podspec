Pod::Spec.new do |s|
  s.name         = "KHSwipeCell"
  s.version      = "0.1.0"
  s.summary      = "An easy-to-use UITableViewCell subclass that implements a swipeable content view"
  s.homepage     = "https://github.com/weekwood/KHSwipeCell"
  s.screenshots  = "https://raw.githubusercontent.com/weekwood/KHSwipeCell/master/gif/KHSwipeCell.gif"
  s.license      = "MIT"
  s.author       =  "Khan.Lau"
  s.platform     = :ios, '6.0'
  s.source       = { :git => "https://github.com/weekwood/KHSwipeCell.git",:tag =>s.version.to_s}
  s.source_files  = "KHSwipeCellExample/KHSwipeCell/*"
  s.requires_arc = true
end
