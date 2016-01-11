class Queen < Piece

  def initialize(color, position)
    super(color, position)
    @value = 9
  end

  def to_chr
    return "\u265B".encode("utf-8") if color == :white
    "\u265B".encode("utf-8").colorize(:black)
  end

end
