module USGS

  def self.clear_database
    Place.delete_all
    Region.delete_all
  end

  def self.create_places
    data = HTTParty.get(ENV['USGS_API_URL'])
    places = []
    data['features'].each do |place|
      place['geometry']['coordinates'].pop #remove the altitude coordinate (not supported by Mongo)
      places << place
    end
    Place.create(places)
  end

  def self.create_regions
    regions = []
    count = 0
    total = Place.all.count
    Place.each do |place|
      region = init_region(place)
      (1..30).each do |days| #data only goes back 30 days
        cutoff_time = (DateTime.now - days.to_i.days).strftime('%Q')
        #only calculate averages for quakes that themselves are within the cutoff
        if place['properties']['time'] >= cutoff_time.to_i
          nearby_quakes = find_nearby_quakes(cutoff_time, place)
          avg_mag = average_magnitudes(nearby_quakes)
          region[:magnitudes][days] = {mag: avg_mag, count: nearby_quakes.count} unless avg_mag.nil?
        end
      end
      count += 1
      p ((count.to_f/total.to_f)*100) #log % progress
      regions << region
    end
    Region.create(regions)
  end

  private
  def init_region(place)
    {
        id: place['id'],
        properties:
            {
                place: place['properties']['place'],
                time: place['properties']['time'],
            },
        magnitudes: {},
        geometry: place['geometry']
    }
  end

  def find_nearby_quakes(cutoff_time, place)
    Place
      .where("this.properties.time >= #{cutoff_time}")
      .geo_near(place['geometry']).spherical
      .max_distance(40233.6) #25 miles in meters
  end

  def average_magnitudes(nearby_quakes)
    return nil if nearby_quakes.empty?
    magnitudes = nearby_quakes.collect {|q| q['properties']['mag']}
    magnitudes.inject(:+) / magnitudes.size.to_f
  end

end