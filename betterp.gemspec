# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'betterp/version'

Gem::Specification.new do |spec|
  spec.name          = 'betterp'
  spec.licenses      = ['MIT']
  spec.version       = Betterp::VERSION
  spec.authors       = ['Bob Farrell']
  spec.email         = ['bob@homeflow.co.uk']

  spec.summary       = 'Enhanced debug output'
  spec.description   = 'Replaces Kernel#p with a fancier version'
  spec.homepage      = 'https://github.com/bobf/betterp'

  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  end
  spec.bindir        = 'bin'
  spec.executables   = []
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'paint', '~> 2.0'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rspec-its', '~> 1.2'
  spec.add_development_dependency 'rubocop', '~> 0.77.0'
  spec.add_development_dependency 'strong_versions', '~> 0.3.2'
end
