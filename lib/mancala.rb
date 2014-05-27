require '../test/test_mancala.rb'
require './modules.rb'
include MancalaTests
include DrawBoard

class Mancala 
 
 attr_accessor :player1, :player2, :slot, :board, :last_deposit_tracker

 def initialize
   @player1 = true 
   @player2 = false 
   @board = [[],["o","o","o","o"],["o","o","o","o"],["o","o","o","o"],["o","o","o","o"],["o","o","o","o"],["o","o","o","o"],
            [],["o","o","o","o"],["o","o","o","o"],["o","o","o","o"],["o","o","o","o"],["o","o","o","o"],["o","o","o","o"]]

   #used in the extra_turn and collect_pebbles methods 
   @last_deposit_tracker ||= [1]
   play
 end 


 ##########game play########

  def play
    draw_board 
    until game_over  
      draw_board
      get_move
      move
      collect_pebbles
      draw_board
      sleep(3.5)
      turn_switch unless extra_turn 
    end  

    win 
  end 


 #########board logic########
 
 #working
 def move   
  @slot = slot 
  #pick the array at the chosen slot number 
  pebbles = @board[@slot]
  #set counter equal to chosen slot 
  count = @slot
  #so if I am player 1 and I slot 6 has 8 marbles for some 
  #reason, the last marble should end up in slot 1 not slot 0 

  #do the following with the pebbles from the chosen slot 
  pebbles.each do |pebble|
    #if a pebble makes it to the last array on the board 
    # and it's player1's turn 
    if count >= 13 && player1
    #set the counter to 0 so the next pebble skips player 2's endzone
    #when @board[count + 1] << pebble is called below   
      count = 0 
    #if a pebble makes it to the last array on the board 
    # and it's player2's turn 
    elsif count >= 13 && player2
    #set the counter to -1 so the next pebble is deposited in  player 2's endzone
    #when @board[count + 1] << pebble is called below   
      count = -1 
    #if a pebble makes it to the last array on player1's side of the board 
    # and it's player2's turn
    elsif count == 6 && player2 
    #set the counter to 7 so the next pebble skips player 1's endzone 
    #when @board[count + 1] << pebble is called below 
      count = 7 
    end
    #deposit the first pebble into the board slot one position ahead 
    @board[count + 1] << pebble 
    draw_board
    sleep(0.5)
    #increment counter by one so the next pebble is put two positions ahead
    count += 1 
    
  end 

  @last_deposit_tracker << count 
  
  #empty the orignally chosen slot 
  @board[@slot] = []
  
  

  @board 

    
 end 

 #working 
 def extra_turn
    #method that gives extra turn to player
    #if they deposit their last stone in their own endzone 
  if @player1 && last_deposit == 7
    return true 
  elsif @player2 && last_deposit == 0
    return true
  else
    return false
  end 
 end 

 #working
 def collect_pebbles
   #if player1 makes a deposit on his own side and if the last slot deposited in was empty before the deposit 
   if @player1 && (last_deposit >= 1 && last_deposit <= 6) && (@board[last_deposit] == ["o"])
      #add the stones from the adjacent slot on player2's side 
      #to player1's endzone
      #this takes advantage of using negative indexing to identify
      #the adjacent slot on player2's side
      @board[7] += @board[-1 * last_deposit]
      #and clear out the adjacent slot on player2's side
      @board[-1 * last_deposit] = []
      return true
    elsif @player2 && (last_deposit >= 8 && last_deposit <= 13) && (@board[last_deposit] == ["o"])
      #for player2, need to subtract 14 from last_deposit 
      #to get it into negative index format
      #and then take the opposite for the adjacent spot 
      #on player1's side of the board 
      @board[0] += @board[-1 * (last_deposit - 14)]
      @board[-1 * (last_deposit - 14)] = []
      return true
    else
      return false
    end 
 end 

  def game_over

    if @board[1..6].flatten.empty? || @board[8..13].flatten.empty?
      return true 
    end 


  end 

 def win 
  if @board[7].length > @board[0].length 
    puts
    puts "Player 1 Wins!"
  elsif @board[7].length < @board[0].length 
    puts 
    puts "Player 2 Wins!"
  else 
    puts
    puts "It's a draw!"
  end 
 end 
 
 #working 
 def turn_switch
  @player1 = !@player1
  @player2 = !@player2 

 end

 ########gets methods########
 
 #working 
 def get_move 
  puts
  #output 'slot choice message' based on player turn 
  puts "Player #{@player1 ? '1' : '2'}, choose a non-empty slot from #{@player1 ? '1-6' : '8-13'}"
  prompt
  @slot = gets.chomp.to_i 
  if move_valid? 
    return @slot
  else
  #call the method recursively 
    get_move
  end 
 
 end 

###########booleans###########
 #working 
 def move_valid? 
  #are there pebbles in the chosen slot? 
  if @board[@slot].length != 0 
    #is player 1 choosing slots 1-6?
    if @player1 && (@slot >= 1 && @slot <= 6) 
      return true 
    #is player2 choosing slots 8-12?
    elsif @player2 && (@slot >= 8 && @slot <= 13) 
      return true
    else 
      return false 
    end
  else 
   #if not, the move is not valid 
    false  
  end 
 end 

 #######helper methods#######
 
 def last_deposit
  @last_deposit_tracker.last
 end 

 def prompt 
  print "> "
 end 
 
 def clear
  puts "\e[H\e[2J\n" 
  puts
  puts 
 end 


##########methods requiring input in testing##########
 
 # def get_move_tester(slot) 
 
 #  #output 'slot choice message' based on player turn 
  
 #  while !move_valid?
 #    puts
 #    puts "Choose a non-empty slot from #{@player1 ? '1-6' : '8-12'}"
 #    prompt
 #  end
  
 #  if move_valid? 
 #    @slot = slot
 #  end
 #  #call the method recursively 
   
 
 # end

 def move_tester(slot)  
  @slot = slot 
  #pick the array at the chosen slot number 
  pebbles = @board[@slot]
  #set counter equal to chosen slot 
  count = @slot
  #so if I am player 1 and I slot 6 has 8 marbles for some 
  #reason, the last marble should end up in slot 1 not slot 0 

  #do the following with the pebbles from the chosen slot 
  pebbles.each do |pebble|
    #if a pebble makes it to the last array on the board 
    # and it's player1's turn 
    if count >= 13 && player1
    #set the counter to 0 so the next pebble skips player 2's endzone
    #when @board[count + 1] << pebble is called below   
      count = 0 
    #if a pebble makes it to the last array on the board 
    # and it's player2's turn 
    elsif count >= 13 && player2
    #set the counter to -1 so the next pebble is deposited in  player 2's endzone
    #when @board[count + 1] << pebble is called below   
      count = -1 
    #if a pebble makes it to the last array on player1's side of the board 
    # and it's player2's turn
    elsif count == 6 && player2 
    #set the counter to 7 so the next pebble skips player 1's endzone 
    #when @board[count + 1] << pebble is called below 
      count = 7 
    end
    #deposit the first pebble into the board slot one position ahead 
    @board[count + 1] << pebble 
    #increment counter by one so the next pebble is put two positions ahead
    count += 1 
    
  end 

  @last_deposit_tracker << count 
   #empty the orignally chose slot 
  @board[@slot] = []
  @board 
    
 end 

 
###############loose ends#########
  #text file for instructions 
  #more in game direction 
  #breaking out files into moduels
  #

 ############################

end 

#move_test
#move_test2
#test_get_move
#test_move_valid?
#test_get_move
#test_get_move_and_move
#test_skip_endzone
#test_extra_turn
#test_collect_pebbles
#test_game_over
#test_win
Mancala.new





