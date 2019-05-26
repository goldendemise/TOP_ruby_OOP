require 'colorize'

# Instantiate the Mastermind game board
class Mastermind
  attr_accessor :rainbow
  attr_reader :secret_code
  def initialize
    @rainbow = %w[red yellow blue green cyan magenta]
    @secret_code = @rainbow.shuffle.take(4)
  end

  def check_result
  end
  
  def player_turn
    puts 'From red, yellow, green, blue, cyan, and magenta,'
    puts 'please enter your four color guess in space delimited format: '
    guess = gets.chomp.split
    guess.each { |color| print '[]'.colorize(color.to_sym) + ' ' }
    print "\n"
  end
end

game = Mastermind.new
game.player_turn
