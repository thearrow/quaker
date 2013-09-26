class QuakesController < ApplicationController

  def index
    count = params[:count] || 10
    days = params[:days] || 10
    region = params[:region]

    render json: 'quakes?' + "count=#{count}&" + "days=#{days}&" + "region=#{region}"
  end

end
