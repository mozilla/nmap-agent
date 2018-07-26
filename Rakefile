require 'rubygems'
require 'rake'
require 'rubygems/package_task'
require 'rspec'
require 'rspec/core'
require 'rspec/core/rake_task'
require 'bundler/setup'

$:.unshift File.join(File.dirname(__FILE__), "lib")

require 'nmap_agent'

task :default => :spec

desc "Run all specs in spec directory"
RSpec::Core::RakeTask.new(:spec)