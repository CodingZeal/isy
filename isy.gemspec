# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'isy/version'

Gem::Specification.new do |spec|
  spec.name          = "isy"
  spec.version       = Isy::VERSION
  spec.authors       = ["Adam Cuppy"]
  spec.email         = ["adam@codingzeal.com"]

  spec.summary       = %q{Type assertion library for method arguments}
  spec.homepage      = "https://github.com/acuppy/isy"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.4.0"
end
