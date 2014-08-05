guard 'rspec' do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/prayer_times/#{m[1]}_spec.rb" }
  watch('spec/helper.rb')  { "spec" }
end
