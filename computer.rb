# frozen_string_literal: true

# Computer class
class Computer
  def initialize(difficulty)
    @difficulty = difficulty
    # @board = Board.new
    @current_board = nil
    @board = nil
  end

  def play_computer(c)
    self.current_board = c
    z = c.map do |val|
      if val == 'x'
        'X'
      elsif val == 'o'
        'O'
      else
        ' '
      end
    end
    self.board = z
    p "computer needs to b X currently"
    best_move(z)
    # difficulty == 'easy' ? easy_game(c) : hard_game(c)
  end

  private

  attr_reader :difficulty
  attr_accessor :current_board, :board

  def winning(b, player)
    winning_combiniations = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    winning_combiniations.any? do |val|
      return player if [b[val[0]], b[val[1]], b[val[2]]].uniq.length == 1 && b[val[0]] == player
    end
    false
  end

  # def hard_game(b)
  #   p find_best_move(b)
  #   find_best_move(b)
  # end

  def available_moves
    moves = []
    board.each_with_index do |cell, i|
      moves << i if cell == ' '
    end
    moves
  end

  def make_move(player, move)
    board[move] = player
  end

  def undo_move(move)
    board[move] = ' '
  end

  def winner
    winning_combinations = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]

    winning_combinations.each do |combo|
      if board[combo[0]] == board[combo[1]] && board[combo[1]] == board[combo[2]] && board[combo[0]] != ' '
        return board[combo[0]]
      end
    end

    nil
  end

  def game_over?
    winner || board.none?(' ')
  end

  def minimax(board, depth, maximizing_player)
    return 1 if winner == 'X'
    return -1 if winner == 'O'
    return 0 if game_over?

    if maximizing_player
      max_eval = -Float::INFINITY
      available_moves.each do |move|
        make_move('X', move)
        eval = minimax(board, depth + 1, false)
        undo_move(move)
        max_eval = [max_eval, eval].max
      end
      max_eval
    else
      min_eval = Float::INFINITY
      available_moves.each do |move|
        make_move('O', move)
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
      make_move('X', move)
      score = minimax(board, 0, false)
      undo_move(move)

      if score > best_score
        best_score = score
        best_move = move
      end
    end

    best_move
  end

  def easy_game(b)
    available = empty_index(b)
    pick = available.sample.to_i
    p "Computer chooses #{pick}"
    pick - 1
  end
end
