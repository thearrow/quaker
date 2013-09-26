class Place
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  index({ geometry: "2dsphere" }, { background: true })
end
