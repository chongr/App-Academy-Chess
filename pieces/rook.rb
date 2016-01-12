class Rook < Piece
  include Orth_module

  def initialize(color, position, board)
    super(color, position, board)
    @value = 5
  end

  def to_chr
    return "\u265C".encode("utf-8") if color == :white
    "\u265C".encode("utf-8").colorize(:black)
  end

  def valid_moves
    valid_moves_orth
  end

end
