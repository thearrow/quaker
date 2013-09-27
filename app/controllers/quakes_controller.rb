class QuakesController < ApplicationController

  def index
    count = params[:count] || 10
    days = params[:days] || 10
    region = params[:region] == 'true'
    json = params[:json] == 'true'

    x_days_ago = (DateTime.now - days.to_i.days).strftime('%Q')

    if region
      @places = Region
        .where("this.properties.time >= #{x_days_ago}")
        .order_by("properties.avg_mag DESC")
        .limit(count)

    else
      @places = Place
        .where("this.properties.time >= #{x_days_ago}")
        .order_by("properties.mag DESC")
        .limit(count)
    end

    render json: MultiJson.dump(@places, :pretty => true) if json
  end

end
