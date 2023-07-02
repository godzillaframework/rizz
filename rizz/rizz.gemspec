#!/usr/bin/env gem build
# encoding: utf-8

require File.expand_path("../../core/lib/core/version.rb", __FILE__)

Gem::Specification.new do |s|
  s.name = "rizz"
  s.authors = ["Krisna Pranav"]
  s.description = "Full Stack Framework"
  s.required_rubygems_version = ">= 1.3.6"
  s.version = Padrino.version
  s.platform = Gem::Platform::RUBY
  s.date = Time.now.strftime("%Y-%m-%d")
  s.license = "MIT"

  s.extra_rdoc_files = Dir["*.rdoc"]
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.rdoc_options  = ["--charset=UTF-8"]

  s.add_dependency("support", Rizz.version)
  s.add_dependency("core",    Rizz.version)
  s.add_dependency("helpers", Rizz.version)
  s.add_dependency("cache",   Rizz.version)
  s.add_dependency("mailer",  Rizz.version)
  s.add_dependency("gen",     Rizz.version)
  s.add_dependency("admin",   Rizz.version)
end