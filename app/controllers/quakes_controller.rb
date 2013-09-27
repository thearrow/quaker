class QuakesController < ApplicationController

  def index
    count = params[:count] || 10
    days = params[:days] || 10
    region = params[:region]

    DateTime.now.strftime('%s')

    x_days_ago = (DateTime.now - days.to_i.days).strftime('%Q')
    @places = Place.where("this.properties.time >= #{x_days_ago}")
      .order_by("properties.mag DESC")
      .limit(count)

    render json: MultiJson.dump(@places, :pretty => true)
  end

end
