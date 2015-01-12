# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'studio_apartment/version'

Gem::Specification.new do |s|
  s.name        = 'studio_apartment'
  s.version     = StudioApartment::VERSION.dup
  s.date        = '2015-01-11'
  s.summary     = "Lightweight multitenanting"
  s.description = "A lightweight multitenanting library that makes few assumptions about your code"
  s.authors     = ["Tom Canham"]
  s.email       = 'tom@arcadianproductions.com'
  s.files       = ["lib/studio_apartment.rb"]
  s.homepage    =
    'http://rubygems.org/gems/studio_apartment'
  s.license       = 'MIT'
  s.platform    = Gem::Platform::RUBY
  s.require_paths = ["lib"]
  s.add_runtime_dependency "request_store"

  s.add_development_dependency "rspec"
  s.add_development_dependency "activerecord"
end