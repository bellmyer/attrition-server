class PlaySafe
  attr_reader :name, :score, :moves
  
  def initialize
    @name = "Play it Safe"
    @score = 100
    @moves = []
  end
  
  def to_json options={}
    {name: name, score: score}
  end
  
  def get_move armies
    soldiers = 1

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