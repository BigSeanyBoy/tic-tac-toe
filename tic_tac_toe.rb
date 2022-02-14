# frozen_string_literal: true

# The Board class represents the tic-tac-toe board; storing
# relevant data and keeping track of the game state.
class Board
  attr_reader :current_player, :state

  def initialize
    @state = (1..9).to_a
    @current_player = 'X'
  end

  def print
    puts
    (0...3).each do |row|
      i = 3 * row
      puts " #{@state[i]} | #{@state[i + 1]} | #{@state[i + 2]}"
      puts '-----------' unless row == 2
    end
    puts
  end

  def add_piece(location)
    @state[location - 1] = @current_player
    switch_player unless game_over?
  end

  def game_over?
    check_rows || check_cols || check_diag
  end

  def switch_player
    @current_player = @current_player == 'X' ? 'O' : 'X'
  end

  def check_rows
    (0...3).each do |row|
      i = 3 * row
      return true if @state[i] == @state[i + 1] && @state[i] == @state[i + 2]
    end
    false
  end

  def check_cols
    (0...3).each do |col|
      i = 3 * col
      return true if @state[i] == @state[i + 3] && @state[i] == @state[i + 6]
    end
    false
  end

  def check_diag
    return true if @state[0] == @state[4] && @state[4] == @state[8]
    return true if @state[2] == @state[4] && @state[4] == @state[6]

    false
  end
end

def get_move(board)
  puts 'Where would you like to place your piece?'
  move = gets.chomp.to_i
  raise exception unless Integer(board.state[move - 1])

  move
rescue StandardError
  puts 'Please enter a valid slot'
  retry
end

def main
  board = Board.new

  until board.game_over?
    board.print
    puts "#{board.current_player}'s turn"
    move = get_move(board)
    board.add_piece(move)
  end

  board.print
  puts "#{board.current_player}'s wins!"
end

main
