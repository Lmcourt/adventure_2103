require 'rspec'
require './lib/hiker'
require './lib/park'
require './lib/trail'

describe Hiker do
  describe '::initialize' do
    it 'exists' do
      hiker = Hiker.new('Dora', :moderate)

      expect(hiker).is_a? Hiker 
    end
    
    it 'has attributes' do
      hiker = Hiker.new('Dora', :moderate)

      expect(hiker.name).to eq 'Dora'
      expect(hiker.experience_level).to eq :moderate
      expect(hiker.snacks).to eq ({})
    end 
  end
end