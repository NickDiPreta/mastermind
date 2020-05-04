class String
  def black;          "\033[30m#{self}\033[0m" end
  def red;            "\033[31m#{self}\033[0m" end
  def green;          "\033[32m#{self}\033[0m" end
  def brown;          "\033[33m#{self}\033[0m" end
  def blue;           "\033[34m#{self}\033[0m" end
  def magenta;        "\033[35m#{self}\033[0m" end
  def cyan;           "\033[36m#{self}\033[0m" end
  def gray;           "\033[37m#{self}\033[0m" end
end

class Mastermind
  attr_accessor :solution_peg_array, :player_hash, :cpu_hash , :Cpu_player  , :player , :coder_input_array
  
  def initialize
    @solution_peg_array = 4.times.map{(['red','green','brown','blue','magenta','cyan'].sample)}
    @player = Player.new
    @coder_input_array = Array.new
  end

  def compare_guess
    if @player.last_guess == @solution_peg_array
      puts "\nI win! #{@player.last_guess} is correct! It took me #{13-@player.guesses_left} guesses!"
    else
      cpu_hash = Hash.new(0)
      player_hash = Hash.new(0)
      matches = 0
      color_only = 0
      incorrect = 0
      j = 0
      while j < 4
        if @solution_peg_array[j] == @player.last_guess[j]
          matches += 1
          @player.saved_guesses[j] = @player.last_guess[j]
        end
        j += 1
      end
      @solution_peg_array.each{|color| cpu_hash[color] +=1}
      @player.last_guess.each{|color| player_hash[color] +=1}
      cpu_hash.each{|key,value| incorrect +=  [(value - player_hash[key]),0].max}
      puts "\n Guess #{13-@player.guesses_left} is wrong... darnit! #{@player.last_guess} is not correct."
      puts "Correctly guessed #{matches} pegs!"
      color_only = 4-(incorrect+matches)
      puts "#{color_only} color-only matches."
      puts "#{incorrect} incorrect"
      @player.guesses_left -=1
      self.play
    end
  end

  def play
    incorrect = 0
    matches = 0
    color_only = 0
    if @player.guesses_left > 0
      @player.make_guess
      self.compare_guess
    else
      puts "No guesses left!"
    end
  end

  def who_is_playing
    puts "Lets Play Mastermind! Would you like to be coder or decoder? (type 'coder' or 'decoder')".red
    coder_or_decoder = gets.chomp
    if coder_or_decoder == 'decoder'
      self.play
    else
      puts "\nSo you think you can code...huh?"
      puts "\nI never lose! Give me 6 guesses...max!"
      puts "Enter your 4 colors! You can choose #{'red'.red}, #{'green'.green}, #{'brown'.brown}, #{'blue'.blue}, #{'magenta'.magenta}, or #{'cyan'.cyan} "
      puts "\nPeg 1"
      @coder_input_array << gets.chomp
      puts "\nPeg 2"
      @coder_input_array << gets.chomp
      puts "\nPeg 3"
      @coder_input_array << gets.chomp
      puts "\nPeg 4"
      @coder_input_array << gets.chomp
      @player.player_human = false
      @solution_peg_array = @coder_input_array
      self.play
    end
end
end


class Player
  attr_accessor :guesses_left, :last_guess, :player_human , :saved_guesses , :colors , :saved_colors, :slot_one_colors, :slot_two_colors, :slot_three_colors, :slot_four_colors
  def initialize
    @guesses_left = 12
    @last_guess = Array.new
    @player_human = true
    @saved_guesses = ['','','','']
    @colors = ['red','green','brown','blue','magenta','cyan']
    @slot_one_colors = ['red','green','brown','blue','magenta','cyan']
    @slot_two_colors = ['red','green','brown','blue','magenta','cyan']
    @slot_three_colors = ['red','green','brown','blue','magenta','cyan']
    @slot_four_colors = ['red','green','brown','blue','magenta','cyan']
  end

  def make_guess
    if @player_human == true
      @last_guess = Array.new
      puts "Guess peg 1"
      @last_guess << gets.chomp
      puts "Guess peg 2"
      @last_guess << gets.chomp
      puts "Guess peg 3"
      @last_guess << gets.chomp
      puts "Guess peg 4"
      @last_guess << gets.chomp
      puts "Last guess was #{last_guess} "
    end
    if @player_human == false
      @last_guess = Array.new
      i = 0
      while i < 4
        if @saved_guesses[i] != ''
          @last_guess[i] = @saved_guesses[i]
        else
          if i == 0
            samp = @slot_one_colors.sample
            @slot_one_colors -= [samp]
            @last_guess[i] =  samp
          elsif i == 1
            samp = @slot_two_colors.sample
            @slot_two_colors -= [samp]
            @last_guess[i] =  samp
          elsif i == 2
            samp = @slot_three_colors.sample
            @slot_three_colors -= [samp]
            @last_guess[i] =  samp
          else 
            samp = @slot_four_colors.sample
            @slot_four_colors -= [samp]
            @last_guess[i] =  samp
          end
        end
        i+=1
      end
    end
    end
  end

  




puts Mastermind.new.who_is_playing
