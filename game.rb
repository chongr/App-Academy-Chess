require_relative 'player.rb'
require_relative 'board.rb'
require_relative 'pieces.rb'
require_relative 'display.rb'
require 'byebug'

class Game

  def initialize(player1, player2)
    @player1 = Player.new(player1, :white)
    @player2 = Player.new(player2, :black)
    @current_player = @player1
    @display = Display.new
    @board = Board.new
    @board.populate
  end

  def play
    over = false
    until over
      winner = take_turn
      @current_player = @current_player == @player1 ? @player2 : @player1
      over = true if winner
    end
    @display.valid_moves = []
    @display.render_board(@board.grid)
    puts "#{winner.to_s.capitalize} wins!!!"
  end

  def take_turn
    valid_move = false
    test_board = []
    until valid_move
      @display.render_board(@board.grid)
      puts "#{@current_player.color.to_s.capitalize}\'s turn."
      selected = @display.get_input
      #debugger
      if selected
        if @display.valid_moves.include?(selected)
          valid_move = true
          @board.move(@selected_position, selected)
          opponents_color = @current_player.color == :white ? :black : :white
          return @current_player.color if @board.checkmate?(opponents_color)
        elsif selected && ((@board.grid[selected[0]][selected[1]].nil?) || (@board.grid[selected[0]][selected[1]].color != @current_player.color))
          @display.valid_moves = []
          @selected_position = nil
        elsif
          @display.valid_moves = @board.grid[selected[0]][selected[1]].valid_moves
          @selected_position = [selected[0], selected[1]]
          @display.valid_moves.reject! do |move|
            test_board = @board.dup
            test_board.move(@selected_position.dup, move)
            test_board.check?(@current_player.color)
            #debugger
          end
          #debugger
        end
      end
    end

    @display.valid_moves = []
    @selected_position = nil
  end

end

if __FILE__ == $PROGRAM_NAME
  the_game = Game.new("Eric", "Rynan")
  the_game.play
end
