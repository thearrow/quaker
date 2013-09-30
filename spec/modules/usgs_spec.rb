require_relative '../spec_helper'
require 'USGS'
include USGS

describe USGS do
  it 'should download and create places' do
    USGS.create_quakes
    expect(Quake.count).to be >= 1
  end
end