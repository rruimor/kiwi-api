require_relative 'lib/kiwi_api'

begin
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new(:spec)

  task :default => :spec
rescue LoadError
  puts 'Yeah'
end

desc "Run KiwiApi console"
task :console do
  require 'pry'
  binding.pry
end