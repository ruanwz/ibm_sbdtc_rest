require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "ibm_sbdtc_rest"
    gem.summary = %Q{isbdtc rest api client}
    gem.description = %Q{isbdtc rest api client}
    gem.email = "ruanwz@gmail.com"
    gem.homepage = "http://github.com/ruanwz/ibm_sbdtc_rest"
    gem.authors = ["David Ruan"]
    gem.add_development_dependency "rspec", ">=1.2.9"
		gem.add_dependency "thor", ">=0.11.8"
		gem.add_dependency "jeweler", ">=1.4.0"
		gem.add_dependency "rest-client", ">=1.0.4"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
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
  rdoc.title = "ibm_sbdtc_rest #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
