module USGS

  def self.reload_data
    data = HTTParty.get(ENV['USGS_API_URL'])

    Place.delete_all

    places = []
    data['features'].each do |place|
      place['geometry']['coordinates'].pop #remove the 'altitude' coordinate (not supported by Mongo)
      places << place
    end

    Place.create(places)
  end

end