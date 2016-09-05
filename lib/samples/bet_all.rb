class BetAll
  attr_reader :name, :score, :moves
  
  def initialize
    @name = "Bet it All!"
    @score = 100
    @moves = []
  end
  
  def to_json options={}
    {name: name, score: score}
  end
  
  def get_move armies
    soldiers = score

    @moves << soldiers
    @score -= soldiers
    
    soldiers
  end
  
  def move
    moves.last
  end
  
  def increment soldiers
    @score += soldiers
  end
  
  def alive?
    @score > 0
  end
end