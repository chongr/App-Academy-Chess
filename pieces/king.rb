class King < Piece

  def initialize(color, position)
    super(color, position)
    @value = 1000
  end

  def to_chr
    return "\u265A".encode("utf-8") if color == :white
    "\u265A".encode("utf-8").colorize(:black)
  end

end
