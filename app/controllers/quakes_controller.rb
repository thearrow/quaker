class QuakesController < ApplicationController

  def index
    count = params[:count] || 10
    days = params[:days].to_i || 10
    days = 30 if days > 30
    days = 1 if days < 1
    region = params[:region] == 'true'

    # Time for X days ago
    cutoff_time = (DateTime.now - days.days).strftime('%Q')

    if region
      regions = Region
        .where("this.properties.time >= #{cutoff_time}")
        .order_by("magnitudes.#{days} DESC")
        .limit(count)

      @places = []
      regions.each do |r|
        r['properties']['title'] = "Avg M: #{r['magnitudes'][days.to_s].to_s} - #{r['properties']['place']}"
        r['magnitudes'] = r['magnitudes'][days.to_s]
        @places << r
      end
    else
      @places = Place
        .where("this.properties.time >= #{cutoff_time}")
        .order_by("properties.mag DESC")
        .limit(count)
    end

    render json: MultiJson.dump(@places, :pretty => true) if params[:format] == 'json'
  end
end
