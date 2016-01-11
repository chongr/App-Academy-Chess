class Board
  attr_accessor :grid
  def initialize
    @grid = Array.new(8) {Array.new(8)}
    populate
  end

  def populate
    populate_back_row(0, :black)
    populate_pawn_row(1, :black)

    populate_pawn_row(6, :white)
    populate_back_row(7, :white)
  end

  def populate_back_row(row_num, color)
    @grid[row_num][0] = Rook.new(color, [row_num, 0])
    @grid[row_num][1] = Knight.new(color, [row_num, 1])
    @grid[row_num][2] = Bishop.new(color, [row_num, 2])
    @grid[row_num][3] = Queen.new(color, [row_num, 3])
    @grid[row_num][4] = King.new(color, [row_num, 4])
    @grid[row_num][5] = Bishop.new(color, [row_num, 5])
    @grid[row_num][6] = Knight.new(color, [row_num, 6])
    @grid[row_num][7] = Rook.new(color, [row_num, 7])
  end

  def populate_pawn_row(row_num, color)
    (0..7).each do |ind|
      @grid[row_num][ind] = Pawn.new(color, [row_num, ind], 1)
    end
  end
end
