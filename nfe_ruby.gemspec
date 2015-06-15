# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nfe_ruby/version'

Gem::Specification.new do |spec|
  spec.name          = "nfe_ruby"
  spec.version       = NfeRails::VERSION
  spec.authors       = ["Jeferson Junior"]
  spec.email         = ["jefersonjr@outlook.com.br"]
  spec.description   = "Geração, assinatura e envio de XML da NF-e"
  spec.summary       = "Geração, assinatura e envio de XML da NF-e"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_dependency 'nokogiri', '~> 1.6.6.2'
  spec.add_dependency "xmldsig"
  spec.add_dependency "savon"
end
