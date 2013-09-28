require 'USGS'
include USGS

desc "This task (used by Heroku Scheduler) reloads all earthquakes from the USGS"
task :reload_data => :environment do
  puts "Updating earthquakes from USGS..."
  puts "Removing old indexes..."
  Rake::Task["db:mongoid:remove_indexes"].execute
  puts "Downloading data & creating places..."
  USGS.create_places
  puts "Creating MongoDB indexes..."
  Rake::Task["db:mongoid:create_indexes"].execute
  puts "Creating regions..."
  USGS.create_regions
  puts "Done."
end