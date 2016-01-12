class Pawn < Piece

  COLOR_DIR = {
    white: 1
    black: -1
  }

  SIDES = [
    1,
    -1
  ]

  def initialize(color, position, board)
    super(color, position, board)
    @value = 1
  end

  def to_chr
    return "\u265F".encode("utf-8") if color == :white
    "\u265F".encode("utf-8").colorize(:black)
  end

  def valid_moves
    move_list = []
    unless @has_moved
      move_list << [@position[0] + 2 * COLOR_DIR[@color], @position[1]] if !@board[@position[0] + 2 * COLOR_DIR[@color]][@position[1]] && !@board[@position[0] + COLOR_DIR[@color]][@position[1]]
      #if @board
    end
    move_list << [@position[0] + COLOR_DIR[@color], @position[1]] if !@board[@position[0] + COLOR_DIR[@color]][@position[1]]
    if @position

    end
  end

end
