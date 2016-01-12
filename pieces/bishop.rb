class Bishop < Piece
  # module Diag_module

  def initialize(color, position, board)
    super(color, position, board)
    @value = 3
  end

  def to_chr
    return "\u265D".encode("utf-8") if color == :white
    "\u265D".encode("utf-8").colorize(:black)
  end

  def valid_moves
    valid_moves_diag
  end

end
