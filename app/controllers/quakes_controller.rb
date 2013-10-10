class QuakesController < ApplicationController
  before_filter :parse_params

  def quakes
    @quakes = Quake
      .where("this.properties.time >= #{get_cutoff_time}")
      .order_by("properties.mag DESC")
      .limit(@count)
  end

  def regions
    @regions = find_regions()
  end

  def vis
    @regions = find_regions()
  end


  private
  def parse_params
    @count = params[:count] || 10
    @days = (params[:days] || 10).to_i
    @days = 30 if @days > 30
    @days = 1 if @days < 1
  end

  # returns a string representing the time for {days} days ago
  # (milliseconds since epoch)
  def get_cutoff_time
    (DateTime.now - @days.days).strftime('%Q')
  end

  def find_regions
    Region
    .where("this.properties.time >= #{get_cutoff_time}")
    .order_by("magnitudes.#{@days} DESC")
    .limit(@count)
  end
end
