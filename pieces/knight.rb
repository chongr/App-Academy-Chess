class Knight < Piece
  POS = [
    [2, 1],
    [1, 2],
    [-2, 1],
    [-1, 2],
    [2, -1],
    [1, -2],
    [-2, -1],
    [-1, -2]
  ]

  def initialize(color, position, board)
    super(color, position, board)
    @value = 3
  end

  def to_chr
    return "\u265E".encode("utf-8") if color == :white
    "\u265E".encode("utf-8").colorize(:black)
  end

  def valid_moves
      move_list = []
      test_pos = [nil, nil]

      POS.each do |move|
        test_pos[0], test_pos[1] = @position[0] + move[0], @position[1] + move[1]

        if (0..7).include?(test_pos[0]) && (0..7).include?(test_pos[1])
          move_list << [test_pos[0], test_pos[1]] if @board.grid[test_pos[0]][test_pos[1]].nil? || @board.grid[test_pos[0]][test_pos[1]].color != @color
        end

      end

      move_list

  end


end
