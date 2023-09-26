# frozen_string_literal: true

# board class
class Board
  attr_reader :board_numbers, :final_result

  def initialize
    @board_numbers = %w[1 2 3 4 5 6 7 8 9]
    @final_result = nil
  end

  def create_board
    [board_numbers[0..2], board_numbers[3..5], board_numbers[6..8]]
  end

  def print_board
    puts "#{create_board[0]}\n#{create_board[1]}\n#{create_board[2]}"
  end

  def game_end?
    game_draw || game_win
  end

  def update_board(index, player_selection)
    board_numbers[index] = player_selection
  end

  private

  def final_board(ind, ind2, ind3)
    board = create_board.flatten
    board[ind] = board[ind].upcase
    board[ind2] = board[ind2].upcase
    board[ind3] = board[ind3].upcase
    @board_numbers = board
  end

  def game_win
    winning_combiniations = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    winning_combiniations.each do |val|
      next unless [board_numbers[val[0]], board_numbers[val[1]], board_numbers[val[2]]].uniq.length == 1

      @final_result = 'Winner'
      final_board(val[0], val[1], val[2])
      return true
    end
    false
  end

  def game_draw
    full_board = create_board.flatten.uniq.include?('x') && create_board.flatten.uniq.include?('o')
    return unless create_board.flatten.uniq.length == 2 && full_board

    @final_result = 'Draw'
    true
  end
end
