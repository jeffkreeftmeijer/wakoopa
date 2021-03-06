# Generated by jeweler
# DO NOT EDIT THIS FILE
# Instead, edit Jeweler::Tasks in Rakefile, and run `rake gemspec`
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{wakoopa}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jeff Kreeftmeijer"]
  s.date = %q{2009-11-29}
  s.description = %q{A simple Ruby Wakoopa API wrapper, built to give you an ActiveRecord-like way to fetch your software usage data.}
  s.email = %q{jeff@kreeftmeijer.nl}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.textile"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.textile",
     "Rakefile",
     "TODO",
     "VERSION",
     "lib/wakoopa.rb",
     "spec/fixtures/jkreeftmeijer_software.xml",
     "spec/spec_helper.rb",
     "spec/wakoopa_spec.rb",
     "wakoopa.gemspec"
  ]
  s.homepage = %q{http://github.com/jeffkreeftmeijer/wakoopa}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{the Ruby Wakoopa API wrapper}
  s.test_files = [
    "spec/spec_helper.rb",
     "spec/wakoopa_spec.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 1.2.8"])
      s.add_runtime_dependency(%q<httparty>, [">= 0.4.5"])
    else
      s.add_dependency(%q<rspec>, [">= 1.2.8"])
      s.add_dependency(%q<httparty>, [">= 0.4.5"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 1.2.8"])
    s.add_dependency(%q<httparty>, [">= 0.4.5"])
  end
end
