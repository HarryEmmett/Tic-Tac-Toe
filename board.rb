class Board
  attr_reader :board_numbers

  def initialize
    @board_numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8]
  end

  def create_board
    [@board_numbers[0..2], @board_numbers[3..5], @board_numbers[6..8]]
  end

  def valid_move(index, player)
    false
  end

  def game_over
  end

  def update_board(index, player)
    return "Invalid Move" if valid_move(index, player)
    return "Game Over" if game_over
    # todo also need to return game over if its the last move
    @board_numbers[index] = player
    @board_numbers
  end
end
