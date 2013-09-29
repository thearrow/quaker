require_relative '../spec_helper'

describe Quake do
  it 'should take dynamic attributes' do
    Quake.create({name: 'my place'})
    Quake.first[:name].should eq('my place')
  end
end
