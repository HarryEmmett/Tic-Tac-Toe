# frozen_string_literal: true

# game setup class
class GameSetup
  def set_opponent
    puts "Playing X's & 0's"
    puts 'Play vs human or computer? (H / C)'
    get_input('h', 'c')
  end

  def computer_difficulty
    puts 'Choose difficulty? (EASY / HARD)'
    get_input('easy', 'hard')
  end

  def get_player(player_number, prev_player_selection = nil, opponent = nil)
    return create_computer(prev_player_selection) if opponent == 'c'

    create_human(player_number, prev_player_selection)
  end

  def lets_play_message(player1, player2)
    puts "Lets play: #{player1.name} (#{player1.selection}) vs #{player2.name} (#{player2.selection})"
  end

  def reset_prompt
    puts 'Play again? (Y / N)'
    restart = get_input('y', 'n')

    if restart.downcase == 'y'
      same_players
    else
      puts 'Thanks for playing!'
      false
    end
  end

  private

  def get_input(inp_a, inp_b)
    input = gets.chomp
    return input.downcase if input.downcase == inp_a || input.downcase == inp_b

    puts "Incorrect entry enter #{inp_a} or #{inp_b}"
    get_input(inp_a, inp_b)
  end

  def create_computer(prev_player_selection)
    prev_player_selection.downcase == 'x' ? Player.new('Computer', 'o') : Player.new('Computer', 'x')
  end

  def create_human(player_num, prev_player_selection)
    puts "Enter player #{player_num}\'s name"
    player_name = gets.chomp
    if prev_player_selection
      prev_player_selection.downcase == 'x' ? Player.new(player_name, 'o') : Player.new(player_name, 'x')
    else
      get_selection(player_name)
    end
  end

  def get_selection(player)
    puts "Enter #{player}\'s selection (X / O)"
    selection = get_input('x', 'o')
    Player.new(player, selection.downcase)
  end

  def same_players
    puts 'Keep same players? (Y / N)'
    get_input('y', 'n')
  end
end
