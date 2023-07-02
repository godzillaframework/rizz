#!/usr/bin/env gem build
# encoding: utf-8

require File.expand_path("../../core/lib/core/version.rb", __FILE__)

Gem::Specification.new do |s|
  s.name = "support"
  s.authors = ["Krisna Pranav"]
  s.required_rubygems_version = ">= 1.3.6"
  s.version = Rizz.version
  s.date = Time.now.strftime("%Y-%m-%d")
  s.license = "MIT"

  s.extra_rdoc_files = Dir["*.rdoc"]
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.rdoc_options  = ["--charset=UTF-8"]
end