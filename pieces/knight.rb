class Knight < Piece

  def initialize(color, position)
    super(color, position)
    @value = 3
  end

  def to_chr
    return "\u265E".encode("utf-8") if color == :white
    "\u265E".encode("utf-8").colorize(:black)
  end

end
