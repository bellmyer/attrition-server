class Game
  attr_reader :players
  
  def initialize players
    @players = players
  end
  
  def play
    count = alive.size
    alive.each{|p| p.get_move(count)}
  end
  
  def sorted
    players.sort_by{|p| 0-p.moves.size}.sort_by{|p| 0-p.score}
  end
  
  def alive
    players.select(&:alive?)
  end
end