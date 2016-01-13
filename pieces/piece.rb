require_relative "diag_module.rb"
require_relative "horz_module.rb" # TODO rename file to match orth

class Piece # TODO create SlidingPiece < Piece and SteppingPiece < Piece classes
  include Orth_module
  include Diag_module

  attr_reader :color, :value
  attr_accessor :position, :has_moved, :alive

  def initialize(color, position, board)
    @color = color
    @position = position
    @board = board
    @has_moved = false
    @alive = true
  end

  def valid_moves
    []
  end

  def dup(new_board)
    new_piece = self.class.new(@color, @position.dup, new_board)
    new_piece.has_moved = @has_moved
    new_piece.alive = @alive
    new_piece
  end

  def pretty_print # TODO remove when done testing
    ["Type = #{self.class}", "Color = #{@color}", "Position = #{@position}", "Has Moved = #{@has_moved}", "Alive = #{@alive}"]
  end

end
