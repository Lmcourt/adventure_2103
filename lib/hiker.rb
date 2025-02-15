class Hiker
  attr_reader :name,
              :experience_level,
              :snacks,
              :parks_visited

  def initialize(name, experience_level)
    @name = name
    @experience_level = experience_level
    @snacks = {}
    @parks_visited = []
  end

  def pack(snack, amount)
    return @snacks[snack] = amount if @snacks[snack].nil?
    @snacks[snack] += amount
  end

  def visit(park)
    @parks_visited << park if !parks_visited.include?(park)    
  end

  def possible_trails 
    possible = @parks_visited.flat_map do |park|
      park.find_trails_by_level(@experience_level)
    end
  end

  def favorite_snack
    most = @snacks.max_by do |snack, quantity|
      quantity
    end
    most[0]
  end
end