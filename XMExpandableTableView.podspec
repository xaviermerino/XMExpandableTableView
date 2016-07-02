#
# Be sure to run `pod lib lint XMExpandableTableView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'XMExpandableTableView'
  s.version          = '0.1.0'
  s.summary          = 'This pod allows creating a UITableView whose cells can expand and collapse when selected. You can customize your cell as much as you want.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  XMExpandableTableView provides a custom UITableViewController class that allows you to quickly implement a TableView that can expand its cells. Cells have a defined collapsed and expanded height. You can customize your cell accordingly.
                       DESC

  s.homepage         = 'https://github.com/xaviermerino/XMExpandableTableView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Xavier Merino' => 'xaviermerino@gmail.com' }
  s.source           = { :git => 'https://github.com/xaviermerino/XMExpandableTableView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/xaviermerino'

  s.ios.deployment_target = '8.0'

  s.source_files = 'XMExpandableTableView/Classes/**/*'

  # s.resource_bundles = {
  #   'XMExpandableTableView' => ['XMExpandableTableView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
