require_relative 'player.rb'
require_relative 'board.rb'
require_relative 'pieces.rb'
require_relative 'display.rb'

class Game

  def initialize(player1, player2)
    @white_player = player1
    @black_player = player2
    @display = Display.new
    @board = Board.new
  end

  def play
    while true
      @display.render_board(@board.grid)
      @display.get_input
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  the_game = Game.new("Eric", "Rynan")
  the_game.play
end
