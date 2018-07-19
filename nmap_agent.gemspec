$: << "lib"
require 'nmap_agent/version'
require 'date'

Gem::Specification.new do |s|
  s.name = 'nmap_agent'
  s.version = NmapAgent::VERSION
  s.authors = ["Jonathan Claudius" ]
  s.date = Date.today.to_s
  s.email = 'jclaudius@mozilla.com'
  s.platform = Gem::Platform::RUBY
  s.files = Dir.glob("lib/**/*") +
            [".gitignore",
             ".rspec",
             ".travis.yml",
             "CONTRIBUTING.md",
             "Gemfile",
             "Rakefile",
             "README.md",
             "nmap_agent.gemspec"]
  s.license       = "ruby"
  s.require_paths = ["lib"]
  s.executables   = s.files.grep(%r{^bin/[^\/]+$}) { |f| File.basename(f) }
  s.summary = 'nmap agent'
  s.description = 'An agent to allow nmap to scan and report back simplified JSON to a centralized data store (likely S3)'
  s.homepage = 'http://rubygems.org/gems/nmap_agent'

  s.add_dependency('ruby-nmap', '0.9.3')
  s.add_dependency('aws-sdk')
end
