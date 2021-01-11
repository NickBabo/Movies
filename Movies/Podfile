# sources
source 'https://github.com/CocoaPods/Specs.git'

# global config
platform :ios, '14.0'
use_frameworks!
workspace 'Movies'

def unitTestingPods
    pod 'Quick'
    pod 'Nimble'
    mockingPods
end

def uiTestingPods
    pod 'Nimble-Snapshots'
end

def mockingPods
    pod 'Cuckoo', '~> 1.4.0'
end

target 'BBNetwork' do
  project 'BBNetwork/BBNetwork'

  # Pods for Network

  target 'BBNetworkTests' do
    unitTestingPods
  end

end
