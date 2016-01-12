class King < Piece

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

    
  end

end
