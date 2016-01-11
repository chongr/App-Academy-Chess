class Bishop < Piece

  def initialize(color, position)
    super(color, position)
    @value = 3
  end

  def to_chr
    return "\u265D".encode("utf-8") if color == :white
    "\u265D".encode("utf-8").colorize(:black)
  end

end
