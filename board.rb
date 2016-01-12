class Board
  attr_accessor :grid, :piece_list, :kings

  #last_moved

  def initialize
    @grid = Array.new(8) {Array.new(8)}
    @piece_list = {white: [], black: []}
    @kings = {white: nil, black: nil}
  end

  def populate
    populate_back_row(0, :black)
    populate_pawn_row(1, :black)

    populate_pawn_row(6, :white)
    populate_back_row(7, :white)
  end

  def populate_back_row(row_num, color)
    @grid[row_num][0] = Rook.new(color, [row_num, 0], self)
    @piece_list[color] << @grid[row_num][0]
    @grid[row_num][1] = Knight.new(color, [row_num, 1], self)
    @piece_list[color] << @grid[row_num][1]
    @grid[row_num][2] = Bishop.new(color, [row_num, 2], self)
    @piece_list[color] << @grid[row_num][2]
    @grid[row_num][3] = Queen.new(color, [row_num, 3], self)
    @piece_list[color] << @grid[row_num][3]
    @grid[row_num][4] = King.new(color, [row_num, 4], self)
    @piece_list[color] << @grid[row_num][4]
    @kings[color] = @grid[row_num][4]
    @grid[row_num][5] = Bishop.new(color, [row_num, 5], self)
    @piece_list[color] << @grid[row_num][5]
    @grid[row_num][6] = Knight.new(color, [row_num, 6], self)
    @piece_list[color] << @grid[row_num][6]
    @grid[row_num][7] = Rook.new(color, [row_num, 7], self)
    @piece_list[color] << @grid[row_num][7]
  end

  def populate_pawn_row(row_num, color)
    (0..7).each do |ind|
      @grid[row_num][ind] = Pawn.new(color, [row_num, ind], self)
      @piece_list[color] << @grid[row_num][ind]
    end
  end

  def move(from_pos, to_pos)
    @grid[to_pos[0]][to_pos[1]].alive = false if @grid[to_pos[0]][to_pos[1]]

    unless @grid[from_pos[0]][from_pos[1]].has_moved
      @grid[from_pos[0]][from_pos[1]].has_moved = true
    end

    @grid[from_pos[0]][from_pos[1]].position = to_pos
    @grid[from_pos[0]][from_pos[1]], @grid[to_pos[0]][to_pos[1]] = nil, @grid[from_pos[0]][from_pos[1]]
  end

  def dup
    duped_board = Board.new
    piece_list.each do |color, pieces_to_place|
      pieces_to_place.each do |the_piece|
        piece_row = the_piece.position[0]
        piece_col = the_piece.position[1]
        duped_board.grid[piece_row][piece_col] = the_piece.dup(duped_board)
        if duped_board.grid[piece_row][piece_col].class == King
          duped_board.kings[color] = duped_board.grid[piece_row][piece_col]
        end
        duped_board.piece_list[color] << the_piece.dup(duped_board)
      end
    end

    duped_board
  end

  def check?(color)
    opponents_color = color == :white ? :black : :white
    opponents_valid_moves = []

    piece_list[opponents_color].each do |piece|
      opponents_valid_moves.concat(piece.valid_moves)
    end

    opponents_valid_moves.include?(@kings[color].position)

  end

end
