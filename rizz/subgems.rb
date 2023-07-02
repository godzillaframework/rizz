rizz_gemspec = ::Gem::Specification.load(File.expand_path(File.dirname(__FILE__) + "/rizz.gemspec"))
performance_gemspec = ::Gem::Specification.load(File.expand_path(File.dirname(__FILE__) + "/../performance/rizz-performance.gemspec"))

RIZZ_SUBGEMS ||= Hash[rizz_gemspec.dependencies.map{ |gem| [gem.name, gem.requirement.to_s] }]

RIZZ_GEMS ||= RIZZ_SUBGEMS.merge(
  'rizz' => rizz_gemspec.version.to_s,
  'rizz-performance' => performance_gemspec.version.to_s,
)