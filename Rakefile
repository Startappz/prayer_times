require "bundler/gem_tasks"
require 'rake/testtask'
 
Rake::TestTask.new do |t|
  t.libs << 'lib/prayer_times'
  t.test_files = FileList['test/lib/prayer_times/*_test.rb']
  t.verbose = true
end
 
task :default => :test

