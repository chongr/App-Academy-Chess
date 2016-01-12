class Queen < Piece
  include Orth_module

  def initialize(color, position, board)
    super(color, position, board)
    @value = 9
  end

  def to_chr
    return "\u265B".encode("utf-8") if color == :white
    "\u265B".encode("utf-8").colorize(:black)
  end

  def valid_moves
    total_moves = []
    total_moves.concat(valid_moves_orth)
    total_moves.concat(valid_moves_diag)
    total_moves
  end

end
