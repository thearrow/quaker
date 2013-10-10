json.array! @regions do |region|
  json.properties do
    json.title "Avg M: #{region['magnitudes'][@days.to_s]['mag'].to_s} - #{region['properties']['place']}"
  end
  json.magnitudes region['magnitudes'][@days.to_s]
end