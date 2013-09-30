require_relative '../spec_helper'

describe Region do
  it 'should take dynamic attributes' do
    Region.create({name: 'my region'})
    expect(Region.first[:name]).to eq('my region')
  end

  it 'should create skeleton hash from quake info' do
    quake = Quake.new({'id' => 1, 'properties' => {'place' => 'here', 'time' => 'now'}, 'geometry' => 'point'})
    region = Region.init_from_quake(quake)
    expect(region[:id]).to eq 1
    expect(region[:properties][:place]).to eq 'here'
  end
end
