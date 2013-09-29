class QuakesController < ApplicationController

  def index
    count = params[:count] || 10
    days = (params[:days] || 10).to_i
    days = 30 if days > 30
    days = 1 if days < 1
    region = params[:region] == 'true'
    vis = params[:vis] == 'true'

    # Time for X days ago
    cutoff_time = (DateTime.now - days.days).strftime('%Q')

    if region
      regions = Region
        .where("this.properties.time >= #{cutoff_time}")
        .order_by("magnitudes.#{days} DESC")
        .limit(count)
      vis ? create_vis_output(days, regions) : create_output(days, regions)
    else
      @quakes = Quake
        .where("this.properties.time >= #{cutoff_time}")
        .order_by("properties.mag DESC")
        .limit(count)
    end

    render json: MultiJson.dump(@quakes, :pretty => true) if params[:format] == 'json'
  end

  private
  def create_vis_output(days, regions)
    @quakes = []
    @quakes << ['Lat', 'Long', 'Avg. Magnitude', '# Quakes']
    regions.each do |r|
      formatted_region = [
          r['geometry']['coordinates'][1],
          r['geometry']['coordinates'][0],
          r['magnitudes'][days.to_s]['mag'],
          r['magnitudes'][days.to_s]['count']
      ]
      @quakes << formatted_region
    end
  end

  def create_output(days, regions)
    @quakes = []
    regions.each do |region|
      region['properties']['title'] = "Avg M: #{region['magnitudes'][days.to_s]['mag'].to_s} - #{region['properties']['place']}"
      region['magnitudes'] = region['magnitudes'][days.to_s]
      @quakes << region
    end
  end
end
