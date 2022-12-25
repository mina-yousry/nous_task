# Uncomment the next line to define a global platform for your project

platform :ios, '14.0'


def ui
  pod 'Kingfisher', '~> 5.0'
  pod 'NVActivityIndicatorView', '4.8.0'
end

def network
  pod 'ReachabilitySwift'
  pod 'Moya', '13.0.0'
end

def utility
  pod 'RxSwift', '6.2.0'
  pod 'RxCocoa', '6.2.0'
  pod 'Action', '5.0.0'
  pod 'RxDataSources', '~> 5.0'
  pod "RxGesture"
end


target 'Nous Task' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  ui
  network
  utility

  # Pods for Nous Task

  target 'Nous TaskTests' do
    inherit! :search_paths
      	ui
  	network
  	utility
  end

end
