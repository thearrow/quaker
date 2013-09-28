require_relative '../spec_helper'

describe Place do
  it 'should take dynamic attributes' do
    Place.create({name: 'my place'})
    Place.first[:name].should eq('my place')
  end
end
