# Instantiate chessboard class
class GameBoard
  attr_accessor :board
  attr_accessor :player_turn
  def initialize
    @board = [['', '', ''], ['', '', ''], ['', '', '']]
    @player_turn = 'X'
    @game_over = false
  end

  private

  def set_cell(x, y, player)
    @board[x][y] = player if @board[x][y] == ''
    @board.each { |row| p row }
  end

  def check_results
    @board.each { |row| p "#{@player_turn} wins!" if row.all? { |letter| letter == row[0] && letter.match?(/[XO]/) } }
  end

  public

  def gameplay
    until @game_over
      puts 'Please enter the coordinates of your next play (i.e., 0,0)'
      coordinates = gets.chomp.split(',')
      redo unless coordinates.all? { |number| number.to_i.between?(0, 2) }
      set_cell(coordinates[0].to_i, coordinates[1].to_i, @player_turn)
      check_results
      @player_turn = 'O' if @player_turn == 'X'
    end
  end
end

board = GameBoard.new
board.gameplay
