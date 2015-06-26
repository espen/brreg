# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'brreg/version'

Gem::Specification.new do |spec|
  spec.name          = "brreg"
  spec.version       = Brreg::VERSION
  spec.authors       = ["Espen Antonsen"]
  spec.email         = ["espen@inspired.no"]

  spec.summary       = "Search Enhetsregisteret"
  spec.description   = "Using Brønnøysundsregisteret API"
  spec.homepage      = "http://github.com/espen/brreg"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = "brreg"
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
end