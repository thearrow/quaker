class Place
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  index geometry: "2dsphere"
  index 'properties.time' => -1
  index 'properties.mag' => -1
end
