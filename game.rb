# frozen_string_literal: true

require './player'
require './board'
require './computer'
require './game_setup'

# Game classs
class Game
  @current_player = nil
  @computer = nil

  def init_game
    setup = GameSetup.new
    board = Board.new
    opponent = setup.set_opponent
    @computer = true if opponent == 'c'
    computer = Computer.new(setup.computer_difficulty) if @computer
    p1 = setup.get_player(1)
    p2 = setup.get_player(2, p1.selection, opponent)
    playing_game(p1, p2, board, computer, setup)
  end

  private

  def playing_game(player1, player2, board, computer, setup)
    setup.lets_play_message(player1, player2)
    playing = true
    while playing
      board.print_board

      @current_player = switch_player(@current_player, player1, player2)

      selection = make_move(@current_player, board, computer)

      board.update_board(selection, @current_player.selection)

      playing = false if board.game_end
    end
    reset_game(player1, player2, board, setup, computer)
  end

  def make_move(current_player, board, computer)
    if @computer && current_player.name == 'Computer'
      computer.computer_choice(board)
    else
      player_turn(@current_player.name, @current_player.selection, board.create_board.flatten)
    end
  end

  def switch_player(player, player1, player2)
    if !player
      player1
    else
      player == player1 ? player2 : player1
    end
  end

  def reset_game(player1, player2, board, setup, computer)
    setup.game_over(board)
    same_players = setup.reset_prompt
    return nil unless same_players
    return init_game if same_players != 'y'

    is_computer = player2.name == 'Computer'
    @computer = is_computer
    @current_player = nil
    playing_game(player1, player2, Board.new, Computer.new(computer.difficulty), GameSetup.new)
  end

  def check_valid_input(player, selection, board, valid_input)
    if board[valid_input - 1] == 'x' || board[valid_input - 1] == 'o'
      puts 'Move already done'
      player_turn(player, selection, board)
    else
      valid_input - 1
    end
  end

  def input_int_val
    input = gets.chomp
    begin
      Integer(input)
    rescue StandardError
      false
    end
  end

  def player_turn(player, selection, board)
    puts "Player #{player}\'s turn (#{selection})"
    valid_input = input_int_val
    puts valid_input
    if !!valid_input && valid_input - 1 && (valid_input - 1).between?(0, 8)
      check_valid_input(p, selection, board, valid_input)
    else
      puts 'Enter a number between 1-9'
      player_turn(p, selection, board)
    end
  end
end
