# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'heartcheck/paypal/version'

Gem::Specification.new do |spec|
  spec.name          = 'heartcheck-paypal'
  spec.version       = Heartcheck::Paypal::VERSION
  spec.authors       = ['Fernando Oléa']
  spec.email         = ['fernando.olea76@gmail.com']

  spec.summary       = 'paypal api checkers to heartcheck'
  spec.description   = 'simple check at paypal create payment heartcheck'
  spec.homepage      = 'https://github.com/feolea/heartcheck-paypal'
  spec.license       = 'MIT'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = 'https://github.com/feolea/heartcheck-paypal/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'heartcheck', '~> 1.5'
  spec.add_development_dependency 'paypal-sdk-rest', '~> 1.7.3'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
