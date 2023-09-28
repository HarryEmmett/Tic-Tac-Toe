# frozen_string_literal: true

require './game'
require './game_setup'
require './board'
require './computer'
require './player'

# game = Game.new
# game.init_game

computer = Computer.new('hard')
computer.play_computer(%w[x 1 2 3 4 5 6 7 8])

# # computer.play_computer(%w[x x x o x o x o o])
# # computer.play_computer(%w[x o x o o x x x o])
# computer.play_computer(%w[x x o x x o 6 o 8])
# # x x o 
# # x x o 
# # 6 o 8