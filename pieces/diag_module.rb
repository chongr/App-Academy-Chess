module Diag_module

  POS = [
    [1, 1],
    [-1, 1],
    [1, -1],
    [-1, -1]
  ]

  def valid_moves_diag
    move_list = []

    POS.each do |inds|

      track_position = @position.dup
      track_position[0] += inds[0]
      track_position[1] += inds[1]
      while (0..7).include?(track_position[0]) && (0..7).include?(track_position[1])
        if !@board.grid[track_position[0]][track_position[1]]
          move_list << track_position.dup
        elsif @board.grid[track_position[0]][track_position[1]].color == @color
          break
        else
          move_list << track_position.dup
          break
        end
        track_position[0] += inds[0] # += -1
        track_position[1] += inds[1] # += -1
      end

    end
    #
    # track_position = @position.dup
    # track_position[0] -= 1
    # track_position[1] += 1
    # while track_position[1] <= 7 && track_position[0] >= 0
    #   if !@board.grid[track_position[0]][track_position[1]]
    #     move_list << track_position.dup
    #   elsif @board.grid[track_position[0]][track_position[1]].color == @color
    #     break
    #   else
    #     move_list << track_position.dup
    #     break
    #   end
    #   track_position[0] -= 1
    #   track_position[1] += 1
    # end
    #
    # track_position = @position.dup
    # track_position[0] += 1
    # track_position[1] -= 1
    # while track_position[1] >= 0 && track_position[0] <= 7
    #   if !@board.grid[track_position[0]][track_position[1]]
    #     move_list << track_position.dup
    #   elsif @board.grid[track_position[0]][track_position[1]].color == @color
    #     break
    #   else
    #     move_list << track_position.dup
    #     break
    #   end
    #   track_position[0] += 1
    #   track_position[1] -= 1
    # end
    #
    # track_position = @position.dup
    # track_position[0] += 1
    # track_position[1] += 1
    # while track_position[1] <= 7 && track_position[0] <= 7
    #   if !@board.grid[track_position[0]][track_position[1]]
    #     move_list << track_position.dup
    #   elsif @board.grid[track_position[0]][track_position[1]].color == @color
    #     break
    #   else
    #     move_list << track_position.dup
    #     break
    #   end
    #   track_position[0] += 1
    #   track_position[1] += 1
    # end

    move_list
  end
end
