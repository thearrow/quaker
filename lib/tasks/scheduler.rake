require 'USGS'
include USGS

desc "This task (used by Heroku Scheduler) reloads all earthquakes from the USGS"
task :reload_data => :environment do
  puts "Updating earthquakes from USGS..."
  USGS.reload_data
  Rake::Task["db:mongoid:create_indexes"].execute
  puts "Done."
end