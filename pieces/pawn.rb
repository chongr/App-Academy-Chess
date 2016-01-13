class Pawn < Piece

  COLOR_DIR = {
    white: -1,
    black: 1
  }

  SIDES = [1, -1]

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
      move_list << [@position[0] + 2 * COLOR_DIR[@color], @position[1]] if !@board.grid[@position[0] + 2 * COLOR_DIR[@color]][@position[1]] && !@board.grid[@position[0] + COLOR_DIR[@color]][@position[1]]
      #if @board.grid
    end
    move_list << [@position[0] + COLOR_DIR[@color], @position[1]] if @position[0] + COLOR_DIR[@color] < 8 && @position[0] + COLOR_DIR[@color] >= 0 && !@board.grid[@position[0] + COLOR_DIR[@color]][@position[1]]

    diagleft = [@position[0] + COLOR_DIR[@color], @position[1] + SIDES[0]]
    diagright = [@position[0] + COLOR_DIR[@color], @position[1] + SIDES[1]]

    move_list << diagleft if diagleft[0] >= 0 && diagleft[0] < 8 && @board.grid[diagleft[0]][diagleft[1]] && @board.grid[diagleft[0]][diagleft[1]].color != @color
    move_list << diagright if diagright[0] >= 0 && diagright[0] < 8 && @board.grid[diagright[0]][diagright[1]] && @board.grid[diagright[0]][diagright[1]].color != @color

    if @board.last_moved_pawn
      #debugger
      rightofpawn = [self.position[0], self.position[1] + 1]
      leftofpawn = [self.position[0], self.position[1] - 1]

      if @board.last_moved_pawn.position == rightofpawn || @board.last_moved_pawn.position == leftofpawn
        move_list << [@board.last_moved_pawn.position[0] + COLOR_DIR[@color], @board.last_moved_pawn.position[1]]
      end
    end

    move_list
  end

end
