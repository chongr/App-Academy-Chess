class Board
  attr_accessor :grid, :piece_list, :kings, :last_moved_pawn

  def initialize
    @grid = Array.new(8) {Array.new(8)}
    @piece_list = {white: [], black: []}
    @kings = {white: nil, black: nil}
    @last_moved_pawn = nil
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
    if @grid[from_pos[0]][from_pos[1]].class == Pawn && !@grid[to_pos[0]][to_pos[1]] && from_pos[1] != to_pos[1]
      @last_moved_pawn.alive = false
      @grid[last_moved_pawn.position[0]][last_moved_pawn.position[1]] = nil
    end

    @last_moved_pawn = nil

    if @grid[from_pos[0]][from_pos[1]].class == King && !@grid[from_pos[0]][from_pos[1]].has_moved && (to_pos[1] == 2 || to_pos[1] == 6)
      if to_pos[1] == 2
        self.move([from_pos[0], 0], [from_pos[0], 3])
      else
        self.move([from_pos[0], 7], [from_pos[0], 5])
      end
    end

    if @grid[from_pos[0]][from_pos[1]].class == Pawn
      if to_pos[0] == 0 || to_pos[0] == 7
        old_pawn = @grid[from_pos[0]][from_pos[1]]
        piece_list[old_pawn.color].delete(old_pawn)
        new_queen = Queen.new(old_pawn.color, old_pawn.position, self)
        piece_list[old_pawn.color].push(new_queen)
        @grid[from_pos[0]][from_pos[1]] = new_queen
      end

      if from_pos[0] - to_pos[0] == 2 || from_pos[0] - to_pos[0] == -2
        @last_moved_pawn = @grid[from_pos[0]][from_pos[1]]
      end
    end


    @grid[to_pos[0]][to_pos[1]].alive = false unless @grid[to_pos[0]][to_pos[1]].nil?

    unless @grid[from_pos[0]][from_pos[1]].has_moved
      @grid[from_pos[0]][from_pos[1]].has_moved = true
    end

    @grid[from_pos[0]][from_pos[1]].position = to_pos
    @grid[from_pos[0]][from_pos[1]], @grid[to_pos[0]][to_pos[1]] = nil, @grid[from_pos[0]][from_pos[1]]

  end

  def dup
    duped_board = Board.new
    if @last_moved_pawn
      duped_board.last_moved_pawn = @last_moved_pawn.dup(self)
    end

    piece_list.each do |color, pieces_to_place|
      pieces_to_place.each do |the_piece|
        if the_piece.alive
          piece_row, piece_col = the_piece.position

          ghost_piece = the_piece.dup(duped_board)
          duped_board.grid[piece_row][piece_col] = ghost_piece
          if duped_board.grid[piece_row][piece_col].class == King
            duped_board.kings[color] = duped_board.grid[piece_row][piece_col]
          end
          duped_board.piece_list[color] << ghost_piece
        end
      end
    end

    duped_board
  end

  def check?(color)
    opponents_color = color == :white ? :black : :white
    opponents_valid_moves = []

    piece_list[opponents_color].each do |piece|
      if piece.alive
        opponents_valid_moves.concat(piece.valid_moves)
      end
    end

    opponents_valid_moves.include?(@kings[color].position)
  end

  def checkmate?(color)
    piece_list[color].each do |piece|
      if piece.alive
        piece_valid_moves = piece.valid_moves
        piece_valid_moves.reject! do |move|
          test_board = self.dup
          test_board.move(piece.position, move)
          test_board.check?(color)
        end

        return false if piece_valid_moves.length > 0
      end
    end

    true
  end
  
end
