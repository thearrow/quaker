# Represents a 25-mile radius region around a quake,
# contains average magnitude and quake count information
# for up to 30 preceding days

class Region
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  # returns a skeleton region hash from quake information
  def self.init_from_quake(quake)
    {
        id: quake['id'],
        properties:
            {
                place: quake['properties']['place'],
                time: quake['properties']['time'],
            },
        magnitudes: {},
        geometry: quake['geometry']
    }
  end
end
