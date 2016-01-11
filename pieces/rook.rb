class Rook < Piece

  def initialize(color, position)
    super(color, position)
    @value = 5
  end

  def to_chr
    return "\u265C".encode("utf-8") if color == :white
    "\u265C".encode("utf-8").colorize(:black)
  end


end
