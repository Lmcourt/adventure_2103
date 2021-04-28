require 'rspec'
require 'date'
require './lib/trail'
require './lib/park'
require './lib/hiker'
require 'pry'

RSpec.configure do |c|
  c.formatter = :documentation
end

RSpec.describe 'Hiker Challenge' do
  describe 'Iteration 1' do
    it '1. Object Creation' do
      trail = Trail.new({name: 'Grand Wash', length: '2.2 miles', level: :easy})
      expect(trail).to be_an_instance_of(Trail)
      expect(trail.name).to eq('Grand Wash')
      expect(trail.length).to eq(2.2)
      expect(trail.level).to eq(:easy)

      park = Park.new('Capitol Reef')
      expect(park).to be_an_instance_of(Park)
      expect(park.name).to eq('Capitol Reef')
      expect(park.trails).to eq([])

      hiker = Hiker.new('Dora', :moderate)
      expect(hiker).to be_an_instance_of(Hiker)
      expect(hiker.name).to eq('Dora')
      expect(hiker.experience_level).to eq(:moderate)
      expect(hiker.snacks).to eq({})
      expect(hiker.parks_visited).to eq([])
    end

    it '2. Park #add_trail' do
      park = Park.new('Capitol Reef')
      trail1 = Trail.new({name: 'Grand Wash', length: '2.2 miles', level: :easy})
      trail2 = Trail.new({name: 'Cohab Canyon', length: '1.7 miles', level: :moderate})

      park.add_trail(trail1)
      park.add_trail(trail2)

      expect(park.trails).to eq([trail1, trail2])
    end

    it '3. Hiker #pack' do
      hiker = Hiker.new('Dora', :moderate)

      hiker.pack('water', 1)
      hiker.pack('trail mix', 3)

      expect(hiker.snacks).to eq({'water' => 1, 'trail mix' => 3})

      hiker.pack('water', 1)

      expect(hiker.snacks).to eq({'water' => 2, 'trail mix' => 3})
    end

    it '4. Hiker #visit' do
      hiker = Hiker.new('Dora', :moderate)
      park1 = Park.new('Capitol Reef')
      park2 = Park.new('Bryce Canyon')

      hiker.visit(park1)
      hiker.visit(park2)

      expect(hiker.parks_visited).to eq([park1, park2])
    end
  end

  describe 'Iteration 2' do
    before :each do
      @trail1 = Trail.new({name: 'Grand Wash', length: '2.2 miles', level: :easy})
      @trail2 = Trail.new({name: 'Cohab Canyon', length: '1.7 miles', level: :moderate})
      @trail3 = Trail.new({name: 'Chimney Rock Loop', length: '3.6 miles', level: :strenuous})
      @trail4 = Trail.new({name: "Queen's/Navajo Loop", length: '2.9 miles', level: :moderate})
      @trail5 = Trail.new({name: 'Rim Trail', length: '11 miles', level: :easy})
      @trail6 = Trail.new({name: 'Tower Bridge', length: '3 miles', level: :moderate})
      @park1 = Park.new('Capitol Reef')
      @park2 = Park.new('Bryce Canyon')
      @hiker = Hiker.new('Dora', :moderate)
      @park1.add_trail(@trail1)
      @park1.add_trail(@trail2)
      @park1.add_trail(@trail3)
      @park2.add_trail(@trail4)
      @park2.add_trail(@trail5)
      @park2.add_trail(@trail6)
      @hiker.visit(@park1)
      @hiker.visit(@park2)
    end

    it '5. Park #trails_shorter_than' do
      expect(@park1.trails_shorter_than(2.5)).to eq([@trail1, @trail2])
      expect(@park2.trails_shorter_than(2.5)).to eq([])
    end

    it '6. Park #hikeable_miles' do
      expect(@park1.hikeable_miles).to eq(7.5)
      expect(@park2.hikeable_miles).to eq(16.9)
    end

    it '7. Hiker #possible_trails' do
      expect(@hiker.possible_trails).to eq([@trail2, @trail4, @trail6])
    end
  end

  describe 'Iteration 3' do
    before :each do
      @trail1 = Trail.new({name: 'Grand Wash', length: '2.2 miles', level: :easy})
      @trail2 = Trail.new({name: 'Cohab Canyon', length: '1.7 miles', level: :moderate})
      @trail3 = Trail.new({name: 'Chimney Rock Loop', length: '3.6 miles', level: :strenuous})
      @trail4 = Trail.new({name: "Queen's/Navajo Loop", length: '2.9 miles', level: :moderate})
      @trail5 = Trail.new({name: 'Rim Trail', length: '11 miles', level: :easy})
      @trail6 = Trail.new({name: 'Tower Bridge', length: '3 miles', level: :moderate})
      @park1 = Park.new('Capitol Reef')
      @park2 = Park.new('Bryce Canyon')
      @hiker = Hiker.new('Dora', :moderate)
      @hiker.pack('water', 2)
      @hiker.pack('trail mix', 1)
      @hiker.pack('apple', 4)
      @hiker.pack('carrot', 3)
      @park1.add_trail(@trail1)
      @park1.add_trail(@trail2)
      @park1.add_trail(@trail3)
      @park2.add_trail(@trail4)
      @park2.add_trail(@trail5)
      @park2.add_trail(@trail6)
      @hiker.visit(@park1)
      @hiker.visit(@park2)
    end

    it '8. Hiker #favorite_snack' do
      expect(@hiker.favorite_snack).to eq('apple')
    end

    it '9. Park #trails_by_level' do
      expected1 = {
        :easy => ["Grand Wash"],
        :moderate => ["Cohab Canyon"],
        :strenuous => ["Chimney Rock Loop"]
      }

      expected2 = {
        :moderate => ["Queen's/Navajo Loop", "Tower Bridge"],
        :easy => ["Rim Trail"]
      }

      expect(@park1.trails_by_level).to eq(expected1)
      expect(@park2.trails_by_level).to eq(expected2)
    end
  end

  describe 'Iteration 4' do
    it '10. Park #visitor_log' do
      trail1 = Trail.new({name: 'Rim Trail', length: '11 miles', level: :easy})
      trail2 = Trail.new({name: "Queen's/Navajo Loop", length: '2.9 miles', level: :moderate})
      trail3 = Trail.new({name: 'Tower Bridge', length: '3 miles', level: :moderate})
      trail4 = Trail.new({name: 'Peekaboo Loop', length: '5.5 miles', level: :strenuous})
      park = Park.new('Bryce Canyon')
      park.add_trail(trail1)
      park.add_trail(trail2)
      park.add_trail(trail3)
      park.add_trail(trail4)
      hiker1 = Hiker.new('Dora', :moderate)
      hiker2 = Hiker.new('Frank', :easy)
      hiker3 = Hiker.new('Jack', :strenuous)
      hiker4 = Hiker.new('Sally', :strenuous)
      allow(Date).to receive(:today).and_return(Date.new(1980, 06, 23))
      hiker1.visit(park)
      allow(Date).to receive(:today).and_return(Date.new(1980, 06, 24))
      hiker2.visit(park)
      allow(Date).to receive(:today).and_return(Date.new(1980, 06, 24))
      hiker3.visit(park)
      allow(Date).to receive(:today).and_return(Date.new(1980, 06, 25))
      hiker4.visit(park)
      allow(Date).to receive(:today).and_return(Date.new(2020, 06, 23))
      hiker1.visit(park)
      allow(Date).to receive(:today).and_return(Date.new(2020, 06, 24))
      hiker2.visit(park)
      allow(Date).to receive(:today).and_return(Date.new(2020, 06, 24))
      hiker3.visit(park)
      allow(Date).to receive(:today).and_return(Date.new(2020, 06, 25))
      hiker4.visit(park)

      expected = {
        1980 => {
          '06/23' => {
            hiker1 => [trail2, trail3]
          },
          '06/24' => {
            hiker2 => [trail1],
            hiker3 => [trail4]
          },
          '06/25' => {
            hiker4 => [trail4]
          }
        },
        2020 => {
          '06/23' => {
            hiker1 => [trail2, trail3]
          },
          '06/24' => {
            hiker2 => [trail1],
            hiker3 => [trail4]
          },
          '06/25' => {
            hiker4 => [trail4]
          }
        }
      }

      expect(park.visitors_log).to eq(expected)
      expect(hiker1.parks_visited).to eq([park])
    end
  end
end