$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "lite_bbs/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "lite_bbs"
  s.version     = LiteBbs::VERSION
  s.authors     = ["Macrow"]
  s.email       = ["Macrow_wh@163.com"]
  s.homepage    = "http://www.github.com/Macrow"
  s.summary     = "LiteBBS can easliy integrate into your exiting or new rails application, it's a mountable engine."
  s.description = "LiteBBS can easliy integrate into your exiting or new rails application, it's a mountable engine.It's a simple, clean forum app engine, it's optimized for phone view."
  
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_dependency "rails"
  s.add_dependency "jquery-rails"
  s.add_dependency "sass-rails"
  s.add_dependency "coffee-rails"
  s.add_dependency "haml-rails"
  s.add_dependency "compass-rails"
  s.add_dependency "bootstrap-sass"
  s.add_dependency "rails_kindeditor"
  s.add_dependency "simple_form"
  s.add_dependency "will_paginate"
  s.add_dependency "cancan"
  s.add_dependency "ransack"
  s.add_dependency "mobylette"
  s.add_dependency "ffaker"
  s.add_dependency "sqlite3"
  s.add_dependency "rspec-rails"
end
