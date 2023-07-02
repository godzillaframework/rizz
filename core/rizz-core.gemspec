#!/usr/bin/env gem build
# encoding: utf-8

require File.expand_path("../lib/core/version.rb", __FILE__)

Gem::Specification.new do |s|
  s.name = "core"
  s.authors = ["Krisna Pranav"]
  s.summary = "The required Rizz core gem"
  s.description = "The Rizz core gem required for use of this framework"
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

  s.add_dependency("support", Rizz.version)
  s.add_dependency("sinatra", ">= 2.2.4")
  s.add_dependency("thor", "~> 1.0")
end