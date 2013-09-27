module USGS

  def self.reload_data
    clear_database
    create_places
    create_regions
  end

  private
  def clear_database
    Place.delete_all
    Region.delete_all
  end

  def create_places
    data = HTTParty.get(ENV['USGS_API_URL'])
    places = []
    data['features'].each do |place|
      place['geometry']['coordinates'].pop #remove the 'altitude' coordinate (not supported by Mongo)
      places << place
    end
    Place.create(places)
  end

  def create_regions
    #region calculation currently uses places from all 30 days...
    #eventually need to only use places within the past X days
    Place.each do |place|
      nearby_quakes = Place
        .geo_near(place['geometry']['coordinates']).spherical
        .max_distance(ENV['REGION_RADIUS'].to_f)

      total_mag = 0.0
      total_quakes = 0.0
      nearby_quakes.each do |q|
        total_mag += q['properties']['mag']
        total_quakes += 1
      end
      avg_mag = total_mag/total_quakes

      Region.create({
          id: place['id'],
          properties: {
              place: place['properties']['place'],
              time: place['properties']['time'],
              avg_mag: avg_mag,
              title: avg_mag.to_s + ' - ' + place['properties']['place']}
      })
    end
  end

end