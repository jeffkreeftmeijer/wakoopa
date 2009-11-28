# Generated by jeweler
# DO NOT EDIT THIS FILE
# Instead, edit Jeweler::Tasks in Rakefile, and run `rake gemspec`
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{wakoopa}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jeff Kreeftmeijer"]
  s.date = %q{2009-11-28}
  s.description = %q{A simple Ruby Wakoopa API wrapper, built to give you an ActiveRecord-like way to fetch data from Wakoopa.com}
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
     "tmp/metric_fu/_data/20091124.yml",
     "tmp/metric_fu/_data/20091125.yml",
     "tmp/metric_fu/_data/20091127.yml",
     "tmp/metric_fu/_data/20091128.yml",
     "tmp/metric_fu/output/churn.html",
     "tmp/metric_fu/output/flay.html",
     "tmp/metric_fu/output/flay.png",
     "tmp/metric_fu/output/flog.html",
     "tmp/metric_fu/output/flog.png",
     "tmp/metric_fu/output/index.html",
     "tmp/metric_fu/output/rcov.html",
     "tmp/metric_fu/output/rcov.png",
     "tmp/metric_fu/output/reek.html",
     "tmp/metric_fu/output/reek.png",
     "tmp/metric_fu/output/roodi.html",
     "tmp/metric_fu/output/roodi.png",
     "tmp/metric_fu/output/saikuro.html",
     "tmp/metric_fu/report.yml",
     "tmp/metric_fu/scratch/flog/lib/wakoopa.md5",
     "tmp/metric_fu/scratch/flog/lib/wakoopa.txt",
     "tmp/metric_fu/scratch/rcov/rcov.txt",
     "tmp/metric_fu/scratch/saikuro/index_cyclo.html",
     "tmp/metric_fu/scratch/saikuro/lib/wakoopa.rb_cyclo.html",
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
