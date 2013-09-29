#This class represents a single earthquake event from the USGS API

class Quake
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  index geometry: "2dsphere"
  index 'properties.time' => -1
  index 'properties.mag' => -1


  #returns all quakes within a 25-mile radius that occurred after the cutoff time
  def find_nearby_quakes(cutoff_time)
    Quake
      .where("this.properties.time >= #{cutoff_time}")
      .geo_near(self.geometry).spherical
      .max_distance(40233.6) #25 miles in meters
  end

  #returns the average magnitude for a group of quakes
  def self.average_magnitudes(quakes)
    magnitudes = quakes.collect {|quake| quake['properties']['mag']}
    magnitudes.inject(:+) / magnitudes.size.to_f
  end
end
