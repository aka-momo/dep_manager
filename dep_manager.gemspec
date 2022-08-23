# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dep_manager/version'

Gem::Specification.new do |spec|
  spec.name          = 'dep_manager'
  spec.version       = DepManager::VERSION
  spec.authors       = ['Mohamed Diaa']
  spec.email         = ['mohamed.diaa27@gmail.com']

  spec.summary       = 'System Library Package Manager for Ruby Gems'
  spec.description   = 'DepManager gem provides the ability to determine
                        and install system-level packages required to
                        build native extensions.'
  spec.homepage      = 'https://github.com/mohameddiaa27/dep_manager'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org.
  # To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or
  # delete this section to allow pushing to any host.

  if spec.respond_to?(:metadata)
    # spec.metadata['allowed_push_host'] = 'https://rubygems.pkg.github.com/mohameddiaa27'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = `git ls-files bin exe lib LICENSE.txt README.md`.split($RS)
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.add_development_dependency('bundler', '~> 2.3.20')
  spec.add_development_dependency('webmock', '~> 2.3')
  spec.add_runtime_dependency 'gemnasium-parser', '~> 0.1.9'
end
