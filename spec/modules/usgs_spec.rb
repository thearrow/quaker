require_relative '../spec_helper'
require 'USGS'
include USGS

describe 'USGS Module' do

  it 'should clear the database' do
    USGS.clear_database
    Place.count.should eq(0)
    Region.count.should eq(0)
  end

  it 'should download and create places' do
    USGS.create_places
    Place.count.should >=(1)
  end
end