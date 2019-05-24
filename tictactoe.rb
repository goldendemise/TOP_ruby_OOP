# get a messy vertical match check out of the check for win method
class Array
  def vertical_match?
    0.upto(2) do |index|
      break unless self[0][index].match?(/[XO]/)

      return true if self[0][index] == self[1][index] && self[1][index] == self[2][index]
    end
    false
  end

  def diagonal_match?
    return unless self[1][1].match?(/[XO]/)

    corner_indices = [[ [0,0], [2,2]], [[2,0], [0,2] ]]
    corner_indices.each do |indices|
        if self[indices[0][0]][indices[0][1]] == self[indices[1][0]][indices[1][1]] && self[indices[0][0]][indices[0][1]] == self[1][1] then
          return true
        end
    end
    false
  end

end
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

  def check_for_win
    @board.each do |row|
    @game_over = true and break if row.all? { |letter| letter == row[0] && letter.match?(/[XO]/) }
    end
    @game_over = true if @board.vertical_match?
    @game_over = true if @board.diagonal_match?
  end

  public

  def gameplay
    until @game_over
      puts 'Please enter the coordinates of your next play (i.e., 0,0)'
      coordinates = gets.chomp.split(',')
      redo unless coordinates.all? { |number| number.to_i.between?(0, 2) }
      set_cell(coordinates[0].to_i, coordinates[1].to_i, @player_turn)
      check_for_win
      #@player_turn = @playter_turn == 'X' ? @player_turn = 'O' : @player_turn = 'X'
      if 'O'.eql? @player_turn then @player_turn = 'X' else @player_turn = 'O' end
    end
    puts "Game over, #{@player_turn} wins!"
  end
end

board = GameBoard.new
board.gameplay
