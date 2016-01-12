require_relative "diag_module.rb"
require_relative "horz_module.rb"

class Piece
  include Orth_module
  include Diag_module

  attr_reader :color, :value
  attr_accessor :position, :has_moved

  def initialize(color, position, board)
    @color = color
    @position = position
    @board = board
    @has_moved = false
  end

  def valid_moves
    []
  end

end
