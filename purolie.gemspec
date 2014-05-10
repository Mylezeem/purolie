# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'purolie/version'

Gem::Specification.new do |spec|
  spec.name          = "purolie"
  spec.version       = Purolie::VERSION
  spec.authors       = ["Yanis Guenane"]
  spec.email         = ["yguenane@gmail.com"]
  spec.summary       = %q{Hiera file generator}
  spec.description   = %q{Purolie generates hiera files by inspecting the role/profile manifests}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_dependency "treetop"
end
