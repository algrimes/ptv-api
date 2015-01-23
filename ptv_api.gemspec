$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "ptv_api"
  s.version     = '0.3.0'
  s.authors     = ["algrimes"]
  s.email       = [""]
  s.homepage    = "http://www.github.com/algrimes/ptv-api-ruby"
  s.summary     = %q{Ruby client for PTV Timetable API}
  s.description = %q{ }

  s.rubyforge_project = "ptv_api"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

end
