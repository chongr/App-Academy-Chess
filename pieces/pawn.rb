class Pawn < Piece

  def initialize(color, position)
    super(color, position)
    @value = 1
    @has_moved = false
  end


end
