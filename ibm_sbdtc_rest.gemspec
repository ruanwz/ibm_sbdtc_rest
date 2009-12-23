# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{ibm_sbdtc_rest}
  s.version = "0.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["David Ruan"]
  s.date = %q{2009-12-23}
  s.default_executable = %q{ibmcloud_admin}
  s.description = %q{isbdtc rest api client}
  s.email = %q{ruanwz@gmail.com}
  s.executables = ["ibmcloud_admin"]
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "bin/ibmcloud_admin",
     "features/ibm_sbdtc_rest.feature",
     "features/step_definitions/ibm_sbdtc_rest_steps.rb",
     "features/support/env.rb",
     "ibm_sbdtc_rest.gemspec",
     "lib/ibm_sbdtc_rest.rb",
     "spec/ibm_sbdtc_rest_spec.rb",
     "spec/spec.opts",
     "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/ruanwz/ibm_sbdtc_rest}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{isbdtc rest api client}
  s.test_files = [
    "spec/ibm_sbdtc_rest_spec.rb",
     "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_development_dependency(%q<cucumber>, [">= 0"])
      s.add_runtime_dependency(%q<thor>, [">= 0.11.8"])
      s.add_runtime_dependency(%q<jeweler>, [">= 1.4.0"])
      s.add_runtime_dependency(%q<rest-client>, [">= 1.0.4"])
    else
      s.add_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_dependency(%q<cucumber>, [">= 0"])
      s.add_dependency(%q<thor>, [">= 0.11.8"])
      s.add_dependency(%q<jeweler>, [">= 1.4.0"])
      s.add_dependency(%q<rest-client>, [">= 1.0.4"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 1.2.9"])
    s.add_dependency(%q<cucumber>, [">= 0"])
    s.add_dependency(%q<thor>, [">= 0.11.8"])
    s.add_dependency(%q<jeweler>, [">= 1.4.0"])
    s.add_dependency(%q<rest-client>, [">= 1.0.4"])
  end
end

