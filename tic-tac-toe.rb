class Board
  attr_reader :current_player
  def initialize
    @state = (1..9).to_a
    @current_player = 'X'
  end

  public
  def print
    puts
    for row in 0...3
      i = 3 * row
      puts " #{@state[i]} | #{@state[i + 1]} | #{@state[i + 2]}"
      unless row == 2
        puts "-----------" 
      end
    end
    puts
  end

  public
  def add_piece(location)
    @state[location - 1] = @current_player
    unless game_over?
      switch_player
    end
  end

  public
  def game_over?
    if check_rows || check_cols || check_diag
      return true
    end
    false
  end

  private
  def switch_player
    @current_player = @current_player == 'X' ? 'O' : 'X'
  end

  private
  def check_rows
    for row in 0...3
      i = 3 * row
      return true if @state[i] == @state[i + 1] && @state[i] == @state[i + 2]
    end
    false
  end

  private
  def check_cols
    for col in 0...3
      i = 3 * col
      return true if @state[i] == @state[i + 3] && @state[i] == @state[i + 6]
    end
    false
  end

  private
  def check_diag
    if @state[0] == @state[4] && @state[4] == @state[8]
      return true
    elsif @state[2] == @state[4] && @state[4] == @state[6]
      return true
    end
    false
  end
end

def main
  board = Board.new

  until board.game_over?
    board.print
    puts "#{board.current_player}'s turn"
    puts "Where would you like to place your piece?"
    move = gets.chomp.to_i
    board.add_piece(move)
  end

  board.print
  puts "#{board.current_player}'s wins!"
end

main
