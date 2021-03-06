lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kiq/helpers/version'

Gem::Specification.new do |gem|
  gem.name          = 'kiq'
  gem.version       = Kiq::VERSION
  gem.authors       = ['Logan McDonald']
  gem.email         = ['logan@logancodes.it']
  gem.description   = %q{Use this command line tool to back Kickstarter campaigns.}
  gem.summary       = %q{Mini Kickstarter Command Line Interface}
  gem.homepage      = 'https://github.com/loganmeetsworld/kiq'
  gem.license       = "MIT"

  gem.files         = `git ls-files`.split($/)
  gem.files         -= gem.files.grep(%r{^\.})
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_development_dependency 'rspec', '~> 2.14'
  gem.add_development_dependency 'rake', '~> 10.1'
  gem.add_development_dependency 'simplecov', '~> 0.12'
end