# frozen_string_literal: true

# Computer class
class Computer
  def initialize(difficulty)
    @difficulty = difficulty
    @winning_combo = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    @board = nil
    @computer = nil
    @human = nil
  end

  def play_computer(current_board, computer, human)
    @computer = computer
    @human = human
    self.board = current_board
    p 'computer needs to b X currently'
    difficulty == 'easy' ? easy_game(current_board) : hard_game(current_board)
  end

  private

  attr_reader :difficulty
  attr_accessor :current_board, :board

  def hard_game(current_board)
    best_move(current_board)
  end

  def easy_game(current_board)
    available = empty_index(current_board)
    pick = available.sample.to_i
    p "Computer chooses #{pick}"
    pick - 1
  end

  def available_moves
    moves = []
    board.each_with_index do |cell, i|
      moves << i if cell != 'o' && cell != 'x'
    end
    moves
  end

  def make_move(player, move)
    board[move] = player
  end

  def undo_move(move)
    board[move] = move.to_s
  end

  def winner
    @winning_combo.each do |val|
      return board[val[0]] if [board[val[0]], board[val[1]], board[val[2]]].uniq.length == 1
    end

    nil
  end

  def game_over?
    includes_selection = board.flatten.uniq.include?('x') && board.flatten.uniq.include?('o')
    winner || board.flatten.uniq.length == 2 && includes_selection
  end

  def minimax(board, depth, maximizing_player)
    return 1 if winner == 'x'
    return -1 if winner == 'o'
    return 0 if game_over?

    if maximizing_player
      max_eval = -Float::INFINITY
      available_moves.each do |move|
        make_move('x', move)
        eval = minimax(board, depth + 1, false)
        undo_move(move)
        max_eval = [max_eval, eval].max
      end
      max_eval
    else
      min_eval = Float::INFINITY
      available_moves.each do |move|
        make_move('o', move)
        eval = minimax(board, depth + 1, true)
        undo_move(move)
        min_eval = [min_eval, eval].min
      end
      min_eval
    end
  end

  def best_move(board)
    best_score = -Float::INFINITY
    best_move = nil

    available_moves.each do |move|
      make_move('x', move)
      score = minimax(board, 0, false)
      undo_move(move)

      if score > best_score
        best_score = score
        best_move = move
      end
    end

    best_move
  end
end
