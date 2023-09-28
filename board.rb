# frozen_string_literal: true

# board class
class Board
  attr_reader :final_result, :board_numbers

  def initialize
    @board_numbers = %w[1 2 3 4 5 6 7 8 9]
    @final_result = nil
    @winning_combiniations = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
  end

  def create_board
    [board_numbers[0..2], board_numbers[3..5], board_numbers[6..8]]
  end

  def print_board
    puts "#{create_board[0]}\n#{create_board[1]}\n#{create_board[2]}"
  end

  def update_board(index, player_selection)
    board_numbers[index] = player_selection
  end

  def game_end?
    game_win || game_draw
  end

  private

  attr_writer :final_result, :board_numbers
  attr_reader :winning_combiniations

  def winning_board_display(ind, ind2, ind3)
    board = create_board.flatten
    board[ind] = board[ind].upcase
    board[ind2] = board[ind2].upcase
    board[ind3] = board[ind3].upcase
    self.board_numbers = board
  end

  def game_win
    winning_combiniations.any? do |val|
      next unless check_combiniation?(val)

      result_message('Winner')
      winning_board_display(val[0], val[1], val[2])
      return true
    end
    false
  end

  def game_draw
    includes_selection = create_board.flatten.uniq.include?('x') && create_board.flatten.uniq.include?('o')
    return unless create_board.flatten.uniq.length == 2 && includes_selection

    result_message('Draw')
    true
  end

  def check_combiniation?(val)
    [board_numbers[val[0]], board_numbers[val[1]], board_numbers[val[2]]].uniq.length == 1
  end

  def result_message(result)
    self.final_result = result
  end
end
