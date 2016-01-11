require 'colorize'

class Display
  def render(grid)
    current_color = :white
    system("clear")
    print " \\  a  b  c  d  e  f  g  h \n"

    grid.each_with_index do |row, ind1|
      print " #{8-ind1} "
      row.each_with_index do |tile, ind2|
        print to_square(tile, current_color)
        if ind2 < 7
          if current_color == :white
            current_color = :black
          else
            current_color = :white
          end
        else
          print "\n"
        end
      end
    end
  end

  def to_square(piece, color)
    if piece
      return " #{piece.to_chr} ".colorize(:background => :light_yellow) if color == :white
      return " #{piece.to_chr} ".colorize(:background => :light_blue )
    else
      return "   ".colorize(:background => :light_yellow) if color == :white
      return "   ".colorize(:background => :light_blue)
    end
  end

end
