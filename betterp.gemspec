# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'betterp/version'

Gem::Specification.new do |spec|
  spec.name          = 'betterp'
  spec.licenses      = ['MIT']
  spec.version       = Betterp::VERSION
  spec.authors       = ['Bob Farrell']
  spec.email         = ['git@bob.frl']

  spec.summary       = 'Enhanced colorized debug output'
  spec.description   = 'Overwrites Kernel#p to provide output with file path, line numbers, and profiling. '
  spec.homepage      = 'https://github.com/bobf/betterp'

  spec.required_ruby_version = '>= 3.2'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  end
  spec.bindir        = 'bin'
  spec.executables   = []
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'paintbrush', '~> 0.1.3'

  spec.metadata['rubygems_mfa_required'] = 'true'
end
