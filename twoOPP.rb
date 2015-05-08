# A simple math quiz game between 2 players
# Players get a point for correct answers
# and lose 1 of 3 lives when they answer incorrectly.
# Future versions should account for ties. For example, If player1
# loses 3 lives in a row, player two doesn't get a chance to answer
# final question.

require_relative "player.rb"
@player1 = Player.new
@player2 = Player.new
@current_player = @player1
@player_turn = true #toggles true = player1's turn, false = player2's turn

def initialize_game
  puts '*** Welcome to the Math Contest Extravagenza! ***'
  puts 'Player 1: Enter your name'
  @player1.name = gets.chomp.to_s
  puts 'Player 2: Enter your name'
  @player2.name = gets.chomp.to_s
end

def print_question_intro()
  puts '--------------------------'
  puts "#{@current_player.name}, it is your turn "
  puts '--------------------------'
  puts 'ready? Press ENTER!'
  gets.chomp
end

#Sets @current_player according to boolean value of @player_turn
def set_next_player
  if @player_turn
    @current_player = @player2
    @player_turn = false
  else
    @current_player = @player1
    @player_turn = true
  end
end

def end_game
set_next_player
puts
puts '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-'
puts "#{@current_player.name} YOU WIN!!!"
puts '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-'
puts 'Final Scores'
puts '============='
puts "#{@player1.name}: Score: #{@player1.points}"
puts "#{@player2.name}: Score: #{@player2.points}"
puts '============='
end

#randomly generates a question and answer and returns it in a hash
def generate_question
  operator = ['+', '-', '*'].sample
  num1 = rand(20)
  num2 = rand(20)
  ans = num1.method(operator).(num2)
  question = "What does #{num1} #{operator.to_s} #{num2} = ?"
  q_and_a = {q: question, a: ans}
end

#main method, self recurring
def next_round (q_a)
  print_question_intro
  puts q_a[:q]
  if gets.chomp.to_i == q_a[:a]
    @current_player.gain_point
    puts "=========================================="
    puts "CORRECT!! #{@current_player.name}, you have #{@current_player.points} points!"
    puts "=========================================="
  else
    @current_player.lose_life
    puts '-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*'
    puts "WRONG!!, the correct answer was #{q_a[:a]}"
    puts "#{@current_player.name}, you have #{@current_player.lives} lives left"
    puts '-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*'
    if @current_player.lives == 0
      end_game
      return
    end
  end
  set_next_player
  next_round(generate_question)
end

initialize_game
next_round(generate_question)
