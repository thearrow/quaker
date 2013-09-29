# Represents a 25-mile radius region around a quake,
# contains average magnitude and quake count information
# for up to 30 preceding days

class Region
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  # returns a skeleton region hash from place information
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
