# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'attr_accessible2strong_params/version'

Gem::Specification.new do |spec|
  spec.name          = "attr_accessible2strong_params"
  spec.version       = AttrAccessible2StrongParams::VERSION
  spec.authors       = ['Eric Guo']
  spec.email         = %q{eric.guo@sandisk.com}
  spec.description   = %q{Automatically convert Rails 3 attr_accessible to Rails 4 Strong Parameter}
  spec.summary       = spec.description
  spec.homepage      = %q{https://github.com/Eric-Guo/attr_accessible2strong_params}
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.required_rubygems_version = Gem::Requirement.new(">= 0") if spec.respond_to? :required_rubygems_version=
  if spec.respond_to? :specification_version then
    spec.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
