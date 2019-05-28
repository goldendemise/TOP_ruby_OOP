require 'colorize'

# Instantiate the Mastermind game board
class Mastermind
  attr_accessor :rainbow
  attr_reader :secret_code
  attr_accessor :turns
  attr_accessor :code_maker
  attr_accessor :computer_guess
  def initialize
    @rainbow = %w[red yellow blue green cyan magenta]
    @secret_code = []
    @code_maker = ''
    @turns = 1
    @computer_guess = []
  end

  def generate_secret
    if @code_maker == 'computer'
      4.times do
        @secret_code.push(@rainbow.sample)
      end
    elsif @code_maker == 'player'
      puts 'Enter four color code in space delimited format'
      @secret_code = gets.chomp.split
    end
  end

  def player_select
    prompt = <<~HEREDOC
      would you like to be:
          1) The Code Maker
          2) The Code Breaker
    HEREDOC
    print prompt
    selection = gets.chomp
    @code_maker = 'player' if selection == 1.to_s
    @code_maker = 'computer' if selection == 2.to_s
  end

  def check_player_result(guess)
    "Code Breaker Win!\n".each_char { |c| print c.colorize(@rainbow.sample.to_sym) } && exit() if guess == @secret_code
    correct = 0
    right_color = 0
    0.upto(3) do |index|
      correct += 1 if @secret_code.include?(guess[index]) && guess[index] == @secret_code[index]
      right_color += 1 if @secret_code.include?(guess[index]) && guess[index] != @secret_code[index]
    end
    puts "Code breaker got #{correct} color/position combinations correct, and #{right_color} that were the correct color but wrong location."
    puts "Turn number:#{@turns}"
    @turns += 1
  end

  def player_guess
    puts 'From red, yellow, green, blue, cyan, and magenta,'
    puts 'please enter your four color guess in space delimited format: '
    guess = gets.chomp.split
    guess.each { |color| print '[]'.colorize(color.to_sym) + ' ' }
    print "\n"
    guess
  end

  def computer_guess
    0.upto(3) do |index|
      @computer_guess[index] = @rainbow.sample if @computer_guess[index].blank?
    end
  end

  def run_game
    while @turns < 13
      user_guess = player_guess if @code_maker == 'computer'
      check_player_result(user_guess)
    end
    "Code Maker Wins!\n".each_char { |c| print c.colorize(@rainbow.sample.to_sym) }if @turns > 12
    "The secret code was:#{@secret_code}"
  end
end

game = Mastermind.new
game.player_select
game.generate_secret
game.run_game
