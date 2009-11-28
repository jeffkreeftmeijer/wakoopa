require 'rubygems'
require 'rake'
require 'metric_fu'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "wakoopa"
    gem.summary = %Q{the Ruby Wakoopa API wrapper}
    gem.description = %Q{A simple Ruby Wakoopa API wrapper, built to give you an ActiveRecord-like way to fetch data from Wakoopa.com}
    gem.email = "jeff@kreeftmeijer.nl"
    gem.homepage = "http://github.com/jeffkreeftmeijer/wakoopa"
    gem.authors = ["jeffkreeftmeijer"]
    gem.add_development_dependency "rspec"
  end
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION')
    version = File.read('VERSION')
  else
    version = ""
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "wakoopa #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
