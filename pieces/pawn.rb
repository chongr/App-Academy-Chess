class Pawn < Piece

  def initialize(color, position)
    super(color, position)
    @value = 1
    @has_moved = false
  end

  def to_chr
    return "\u265F".encode("utf-8") if color == :white
    "\u265F".encode("utf-8").colorize(:black)
  end

end
