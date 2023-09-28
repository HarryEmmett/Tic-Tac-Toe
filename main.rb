# frozen_string_literal: true

require './game'
require './game_setup'
require './board'
require './computer'
require './player'

# game = Game.new
# game.init_game

computer = Computer.new('hard')
# computer.play_computer(%w[o x o x o x 6 7 8])

# computer.play_computer(%w[x x x o x o x o o])
# computer.play_computer(%w[x o x o o x x x o])
computer.play_computer(%w[x x o x o o 6 7 8])
# x x o 
# x o o 
# 6 7 8