require_relative '../spec_helper'

describe Quake do
  it 'should take dynamic attributes' do
    Quake.create({name: 'my quake'})
    expect(Quake.first[:name]).to eq('my quake')
  end

  it 'should average quake magnitudes' do
    Quake.create([
        {properties: {mag: 1.0}},
        {properties: {mag: 1.0}},
        {properties: {mag: 10.0}},
    ])
    expect(Quake.average_magnitudes(Quake.all)).to eq(4.0)
  end
end
