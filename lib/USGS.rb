# Responsible for downloading the quake info from USGS
# and creating Quakes and Regions

module USGS

  # Downloads info from USGS and creates Quake objects
  def self.create_quakes
    data = HTTParty.get(USGS_CONFIG['url'])
    quakes = []
    data['features'].each do |quake|
      quake['geometry']['coordinates'].pop #remove the altitude coordinate (not supported by Mongo)
      quakes << quake
    end
    Quake.delete_all
    Quake.create(quakes)
  end

  # Creates one Region per Quake with average magnitudes and counts
  def self.create_regions
    regions = []
    count = 0
    total = Quake.all.count
    Quake.each do |quake|
      region = Region.init_from_quake(quake)
      (1..30).each do |days| #data only goes back 30 days
        cutoff_time = (DateTime.now - days.to_i.days).strftime('%Q')
        #only calculate averages for quakes that themselves are within the cutoff
        if quake['properties']['time'] >= cutoff_time.to_i
          nearby_quakes = quake.find_nearby_quakes(cutoff_time)
          unless nearby_quakes.empty?
            avg_mag = Quake.average_magnitudes(nearby_quakes)
            region[:magnitudes][days] = {mag: avg_mag, count: nearby_quakes.count}
          end
        end
      end
      count += 1
      p ((count.to_f/total.to_f)*100) #log % progress
      regions << region
    end
    Region.delete_all
    Region.create(regions)
  end
end