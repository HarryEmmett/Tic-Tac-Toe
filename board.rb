# board class
class Board
  attr_reader :final_result

  def initialize
    @board_numbers = %w[1 2 3 4 5 6 7 8 9]
  end

  def create_board
    [@board_numbers[0..2], @board_numbers[3..5], @board_numbers[6..8]]
  end

  def print_board(game_end: false)
    if game_end && game_win
      puts "#{game_win[0]}\n#{game_win[1]}\n#{game_win[2]}"
    else
      puts "#{create_board[0]}\n#{create_board[1]}\n#{create_board[2]}"
    end
  end

  def game_end
    if game_draw
      @final_result = 'Draw'
    elsif game_win
      @final_result = 'Winner'
    end
  end

  def update_board(index, player)
    @board_numbers[index] = player
  end

  private

  def final_board(ind, ind2, ind3)
    board = create_board.flatten
    board[ind] = board[ind].upcase
    board[ind2] = board[ind2].upcase
    board[ind3] = board[ind3].upcase
    [board[0..2], board[3..5], board[6..8]]
  end

  def game_win
    winning_combiniations = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    result = nil
    winning_combiniations.each do |val|
      if [@board_numbers[val[0]], @board_numbers[val[1]], @board_numbers[val[2]]].uniq.length == 1
        result = final_board(val[0], val[1], val[2])
      end
    end

    result
  end

  def game_draw
    full_board = create_board.flatten.uniq.include?('x') && create_board.flatten.uniq.include?('o')
    create_board.flatten.uniq.length == 2 && full_board
  end
end
