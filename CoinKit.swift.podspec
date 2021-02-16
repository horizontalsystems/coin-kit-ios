Pod::Spec.new do |s|
  s.name             = 'CoinKit.swift'
  s.module_name      = 'CoinKit'
  s.version          = '0.1.0'
  s.summary          = 'Kit provides coins data for app and mapping ids for other providers'

  s.homepage         = 'https://github.com/horizontalsystems/coin-kit-ios'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Horizontal Systems' => 'hsdao@protonmail.ch' }
  s.source           = { git: 'https://github.com/horizontalsystems/coin-kit-ios', tag: "#{s.version}" }
  s.social_media_url = 'http://horizontalsystems.io/'

  s.ios.deployment_target = '11.0'
  s.swift_version = '5'

  s.source_files = 'CoinKit/Classes/**/*'
  s.resource_bundle = { 'CoinKit' => ['CoinKit/Assets/*.xcassets', 'CoinKit/Assets/*.lproj/*.strings', 'CoinKit/Resources/*.json'] }

  s.requires_arc = true

  s.dependency 'RxSwift', '~> 5.0'
  s.dependency 'RxSwiftExt', '~> 5'
  s.dependency 'GRDB.swift', '~> 4.0'
  s.dependency 'ObjectMapper', '~> 3.5.2'
end
