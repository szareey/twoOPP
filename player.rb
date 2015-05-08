class Player
  attr_accessor :name
  attr_reader(:points, :lives)

  def initialize()
    @points = 0
    @lives = 3
  end

  def gain_point
    @points += 1
  end

  def lose_life
    @lives -= 1
  end

end
