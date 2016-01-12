require 'colorize'
require_relative "cursorable.rb"

class Display
  include Cursorable
  attr_reader :cursor_pos
  attr_accessor :valid_moves

  def initialize
    @cursor_pos = [7, 3]
    @valid_moves = []
  end

  def render_board(grid)
    @board = grid
    current_color = :white
    system("clear")
    print " \\  a  b  c  d  e  f  g  h \n"

    grid.each_with_index do |row, ind1|
      print " #{8-ind1} "
      row.each_with_index do |tile, ind2|
        if [ind1, ind2] == @cursor_pos
          print to_square(tile, current_color).colorize(:background => :light_red)
        elsif @valid_moves.include?([ind1, ind2])
          print to_square(tile, current_color).colorize(:background => :light_green)
        else
          print to_square(tile, current_color)
        end
        if ind2 < 7
          if current_color == :white
            current_color = :black
          else
            current_color = :white
          end

          # current_color = current_color == :white ? :black : :white
        else
          print "\n"
        end

      end
    end
  end

  def to_square(piece, color)
    if piece
      return " #{piece.to_chr} ".colorize(:background => :light_black) if color == :white
      return " #{piece.to_chr} ".colorize(:background => :light_blue)
    else
      return "   ".colorize(:background => :light_black) if color == :white
      return "   ".colorize(:background => :light_blue)
    end
  end

end
