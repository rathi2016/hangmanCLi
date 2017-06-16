require 'net/http'
require 'open-uri'
require 'json'

class Hangman

  def self.get_random_word
   uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
   Net::HTTP.post_form(uri ,{}).body
 end
attr_accessor :random_word
  def initialize
    @random_word = Hangman.get_random_word
    @turn = 0
    @guessed_letters = []
    @correct_letters = []
    @final_word = []
  end

  def start

    puts "====================================================================="
    puts "Hello!  Welcome to a command line version of the classic Hangman."
    puts "Would you like to start a new game or would you like to load a game?"
    print "Please type 'new' or 'load': "
    choice = gets.chomp
    choose_game(choice)
  end

  def choose_game(choice)
    if choice == 'new'
      new_game
    elsif choice == 'load'
      load_game
    else
      puts "Sorry we didnt understand that, please try again"
      start
    end
  end

  def new_game
    puts "====================================================================="
    puts "Excellent choice!  The word we have chosen for you "
    puts "is #{@random_word.length} letters long.  Good Luck!"
    puts "====================================================================="
    run
  end

  def load_game
    puts "====================================================================="
    puts "Finding last game state.............................................."
    puts "====================================================================="
    load
    run
  end

  def run
    initialize_arrays
    hangman_graphic
    play
    lose
  end
  def hidden_word_array
    @hidden_word = @random_word.split("")
    @hidden_word.pop
  end

  def initialize_arrays
    hidden_word_array
    initialize_final_word_array
  end

  def play
   while @turn < 6
     turn
     win
   end
 end

 def win
   if @hidden_word.all? { |letters| @correct_letters.include?(letters) }
     puts "You won! Congrats!"
     puts ""
     abort
   end
 end
 def turn
    puts "Letters Guessed: #{@guessed_letters}"
    guess
    hangman_graphic
    print_tiles_array
    puts ""
  end
  def print_tiles_array
    @final_word.each do |letter, index|
      print " #{letter} "
    end
  end
  def lose
    puts ""
    puts "Game Over!"
    puts "The special word was actually #{@random_word}"
  end

  def guess
    print "Please type 'save' to save current game "\
           "or guess a letter: "
    letter = gets.chomp.to_s.downcase
    if letter == 'save'
      save
    elsif @guessed_letters.include?(letter)
      puts "#{letter.upcase} has already been guessed!"
      guess
    elsif letter.length != 1
      puts "Please guess exactly 1 letter"
      guess
    else
      @guessed_letters << letter
      if @hidden_word.include?(letter)
        puts ""
        puts "#{letter.capitalize} was found!"
        @correct_letters << letter
        match?(letter)
      else
        puts ""
        puts "#{letter.capitalize} was not found!"
        @turn += 1
      end
    end
  end

  def turn
    puts "Letters Guessed: #{@guessed_letters}"
    guess
    hangman_graphic
    print_tiles_array
    puts ""
  end

  def initialize_final_word_array
    word_length = @hidden_word.length
    word_length.times do
      @final_word << " _ "
    end
  end

  def match?(letter)
    @hidden_word.each_with_index do |l, index|
      if l == letter
        @final_word[index] = letter
      end
    end
  end

  def hangman_graphic
    case @turn
    when 0
      puts ""
      puts "      __________"
      puts "      |        |"
      puts "               |"
      puts "               |"
      puts "               |"
      puts "               |"
      puts "               |"
      puts "               |"
      puts "    ============"
    when 1
      puts ""
      puts "      __________"
      puts "      |        |"
      puts "      0        |"
      puts "               |"
      puts "               |"
      puts "               |"
      puts "               |"
      puts "               |"
      puts "    ============"
    when 2
      puts ""
      puts "      __________"
      puts "      |        |"
      puts "      0        |"
      puts "      |        |"
      puts "      |        |"
      puts "               |"
      puts "               |"
      puts "               |"
      puts "    ============"
    when 3
      puts ""
      puts "      __________"
      puts "      |        |"
      puts "      0        |"
      puts "      |/       |"
      puts "      |        |"
      puts "               |"
      puts "               |"
      puts "               |"
      puts "    ============"
    when 4
      puts ""
      puts "      __________"
      puts "      |        |"
      puts "      0        |"
      puts "     \\|/       |"
      puts "      |        |"
      puts "               |"
      puts "               |"
      puts "               |"
      puts "    ============"
    when 5
      puts ""
      puts "      __________"
      puts "      |        |"
      puts "      0        |"
      puts "     \\|/       |"
      puts "      |        |"
      puts "     /         |"
      puts "               |"
      puts "               |"
      puts "    ============"
    when 6
      puts ""
      puts "      __________"
      puts "      |        |"
      puts "      0        |"
      puts "     \\|/       |"
      puts "      |        |"
      puts "     / \\       |"
      puts "               |"
      puts "               |"
      puts "    ============"
    end
  end


end
test = Hangman.new.start
