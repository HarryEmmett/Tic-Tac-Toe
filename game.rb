# frozen_string_literal: true

# Game classs
class Game
  attr_reader :setup, :game_board, :current_player, :computer, :player1, :player2

  def initialize
    @setup = GameSetup.new
    @game_board = Board.new
    @current_player = nil
    @computer = nil
    @player1 = nil
    @player2 = nil
  end

  def init_game
    opponent = setup.set_opponent
    @computer = Computer.new(setup.computer_difficulty) if opponent == 'c'
    @player1 = setup.get_player(1)
    @player2 = setup.get_player(2, player1.selection, opponent)
    playing_game
  end

  private

  def playing_game
    setup.lets_play_message(player1, player2)
    playing = true
    while playing
      game_board.print_board

      @current_player = switch_player

      selection = make_move

      game_board.update_board(selection, current_player.selection)

      playing = false if game_board.game_end?
    end
    reset_game
  end

  def make_move
    if computer && current_player.name == 'Computer'
      computer.computer_choice(game_board.board_numbers)
    else
      player_turn
    end
  end

  def switch_player
    if !current_player
      player1
    else
      current_player == player1 ? player2 : player1
    end
  end

  def reset_game
    p game_board.final_result
    game_board.print_board
    reset_same_players = setup.reset_prompt
    return nil unless reset_same_players

    @game_board = Board.new
    @current_player = nil
    return playing_game if reset_same_players == 'y'

    @computer = nil
    init_game
  end

  def check_valid_move(valid_input)
    move_taken = game_board.board_numbers[valid_input - 1] == 'x' || game_board.board_numbers[valid_input - 1] == 'o'
    if move_taken
      puts 'Move already done'
      player_turn
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

  def player_turn
    puts "Player #{current_player.name}\'s turn (#{current_player.selection})"
    valid_input = input_int_val
    if !!valid_input && valid_input - 1 && (valid_input - 1).between?(0, 8)
      check_valid_move(valid_input)
    else
      puts 'Enter a number between 1-9'
      player_turn
    end
  end
end
