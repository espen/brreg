# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'brreg/version'

Gem::Specification.new do |spec|
  spec.name          = "brreg"
  spec.version       = Brreg::VERSION
  spec.authors       = ["Espen Antonsen"]
  spec.email         = ["espen@inspired.no"]

  spec.summary       = "Search Enhetsregisteret i Brønnøysundsregisteret"
  spec.description   = "Search Norwegian companies"
  spec.homepage      = "http://github.com/espen/brreg"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = "brreg"
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
end