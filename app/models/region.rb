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

  # return a simple array of lat, lng, avg magnitude, quake count
  # for use in the Google Geochart visualization
  # see vis.json.jbuilder
  def vis_output(days)
    [
        self['geometry']['coordinates'][1],
        self['geometry']['coordinates'][0],
        self['magnitudes'][days.to_s]['mag'],
        self['magnitudes'][days.to_s]['count']
    ]
  end
end
