class King < Piece

POS_MOVES_DIFFS = [
  [1, 0],
  [1, -1],
  [1, 1],
  [0, -1],
  [0, 1],
  [-1, 0],
  [-1, -1],
  [-1, 1]
]

  def initialize(color, position, board)
    super(color, position, board)
    @value = 1000
  end

  def to_chr
    return "\u265A".encode("utf-8") if color == :white
    "\u265A".encode("utf-8").colorize(:black)
  end

  def valid_moves
    move_list = []
    POS_MOVES_DIFFS.each do |cur_diff|
      new_row = @position[0] + cur_diff[0]
      new_col = @position[1] + cur_diff[1]
      in_range = (0..7).include?(new_row) && (0..7).include?(new_col)
      if in_range && @board.grid[new_row][new_col]
        on_piece = @color == @board.grid[new_row][new_col].color ? true : false
      end
      move_list << [new_row, new_col] if in_range and !on_piece
    end
    move_list.concat(self.castles)

    move_list
  end

  def castles
    return [] if @has_moved
    valids = []
    if @board.grid[position[0]][0] && @board.grid[position[0]][0].class == Rook && !@board.grid[position[0]][0].has_moved
      if !@board.grid[position[0]][1] && !@board.grid[position[0]][2] && !@board.grid[position[0]][3]
        valids << [position[0], 2]
      end
    end
    if @board.grid[position[0]][7] && @board.grid[position[0]][7].class == Rook && !@board.grid[position[0]][7].has_moved
      if !@board.grid[position[0]][5] && !@board.grid[position[0]][6]
        valids << [position[0], 6]
      end
    end
    valids
  end

end
