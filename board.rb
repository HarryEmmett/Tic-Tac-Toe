class Board
  attr_reader :board_numbers

  def initialize
    @board_numbers = %w[1 2 3 4 5 6 7 8 9]
  end

  def create_board
    [@board_numbers[0..2], @board_numbers[3..5], @board_numbers[6..8]]
  end

  def valid_move(_index, _player)
    false
  end

  def game_over
    create_board.flatten.uniq.length == 2 && !!create_board.flatten.uniq.include?('x') && !!create_board.flatten.uniq.include?('o')
  end

  def final_board
    # TODO: capitalize winning score to highlight
    create_board[0][0].upcase
  end

  def update_board(index, player)
    # return "Invalid Move" if valid_move(index, player)
    @board_numbers[index] = player
    'Game Over' if game_over
  end
end
