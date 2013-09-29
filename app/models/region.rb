class Region
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  def self.init_from_place(place)
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

end
