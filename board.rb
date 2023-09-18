class Board
  attr_reader :board_numbers

  def initialize
    @board_numbers = %w[1 2 3 4 5 6 7 8 9]
  end

  def create_board
    [@board_numbers[0..2], @board_numbers[3..5], @board_numbers[6..8]]
  end

  def winning_board
    case true
    when @board_numbers[0..2].uniq.length == 1
      final_board(0, 1, 2)
    when @board_numbers[3..5].uniq.length == 1
      final_board(3, 4, 5)
    when @board_numbers[6..8].uniq.length == 1
      final_board(6, 7, 8)
    when [@board_numbers[0], @board_numbers[3], @board_numbers[6]].uniq.length == 1
      final_board(0, 3, 6)
    when [@board_numbers[1], @board_numbers[4], @board_numbers[7]].uniq.length == 1
      final_board(1, 4, 7)
    when [@board_numbers[2], @board_numbers[5], @board_numbers[8]].uniq.length == 1
      final_board(2, 5, 8)
    when [@board_numbers[0], @board_numbers[4], @board_numbers[8]].uniq.length == 1
      final_board(0, 4, 8)
    when [@board_numbers[2], @board_numbers[4], @board_numbers[6]].uniq.length == 1
      final_board(2, 4, 6)
    end
  end

  def game_over
    create_board.flatten.uniq.length == 2 && !!create_board.flatten.uniq.include?('x') && !!create_board.flatten.uniq.include?('o')
  end

  def final_board(ind, ind2, ind3)
    board = create_board.flatten
    board[ind] = board[ind].upcase
    board[ind2] = board[ind2].upcase
    board[ind3] = board[ind3].upcase
    [board[0..2], board[3..5], board[6..8]]
  end

  def update_board(index, player)
    @board_numbers[index] = player
    'Game Over' if game_over
    return unless winning_board

    winning_board
  end
end
