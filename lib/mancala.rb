#SETUP
#2 players
#start with an even distribution of stones 
#4 stones in each of 12 "non-end-zone" slots on the game board
# 48 total stones 
# Each player a side of the board
# and an end-zone (to the right of their side from the player's persp.)
#where they deposit their stones 

#MOVING  & SCORING 
#play starts with the player on the bottom side of the board
#picking the stones from anyone of his/her 6 slots
#then, moving counter-clockwise
#the player deposits the stones 1 at a time
#into the sucessive slots 

#if the players depositing includes their own endzone
  #they deposit the stone in their endzone 
#if the depositing includes the other players endzone 
  #they skip it and move on to the next slot(which is their own)

#if the last piece a player deposits is in their own endzone 
  #they get a free turn 
#if the last piece they deposit is in an empty slot on their side
	#they get all the pieces opposite that slot in their endzone 

#barring a free turn, play alternates after every move 
# use 

#WINNING
# Play stops when all the stones are cleared from one side of the board
# The player with the greatest number of stones in his/her endzone at this 
# point is the winner 

require './test/test_mancala.rb'
include MancalaTests

class Mancala 
 
 #accesor for testing purposes 
 attr_accessor :player1, :player2, :slot, :board, :last_deposit_tracker

 #attr_reader   :player1, :player2, :slot, :board
  
 def initialize
   @player1 = true 
   @player2 = false 
   @board = [[],[1,1,1,1],[1,1,1,1],[1,1,1,1],[1,1,1,1],[1,1,1,1],[1,1,1,1],
            [],[1,1,1,1],[1,1,1,1],[1,1,1,1],[1,1,1,1],[1,1,1,1],[1,1,1,1]]

  #used in the extra_turn and collect_pebbles methods 
  @last_deposit_tracker = []
   #this @board to be used only with test_skip_endzone
   # @board = [[],[1,1,1,1],[1,1,1,1],[1,1,1,1],[1,1,1,1],[1,1,1,1],[1,1,1,1,1,1,1,1],
   #           [],[1,1,1,1],[1,1,1,1],[1,1,1,1],[1,1,1,1],[1,1,1,1],[1,1,1,1,1,1,1,1]]
   #play
   #my suspicion is that play 
   #will eventually have to be in 
   #initialize to set the game in motion 
 end 


 ##########game play########


  def play
    until game_over    
      get_move
      move
      collect_pebbles
      puts
      board_show
      puts
      turn_switch unless extra_turn
    end  

    win 
  end 

 #########board logic########
 
 def board_show

  p @board 

 end 
  
 #almost working, have to write skip opposite player's endzone
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
    #increment counter by one so the next pebble is put two positions ahead
    count += 1 
    
  end 

  @last_deposit_tracker << count 
  
  #empty the orignally chose slot 
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
   #if player1 makes a deposit on his own side
   if @player1 && (last_deposit >= 1 && last_deposit <= 6)
     #if the last slot deposited in was empty before the deposit 
     if @board[last_deposit] == [1]
      #add the stones from the adjacent slot on player2's side 
      #to player1's endzone
      #this takes advantage of using negative indexing to identify
      #the adjacent slot on player2's side
      @board[7] += @board[-1 * last_deposit]
      #and clear out the adjacent slot on player2's side
      @board[-1 * last_deposit] = []
     end
    elsif @player2 && (last_deposit >= 8 && last_deposit <= 13)
     if @board[last_deposit] == [1]
      #for player2, need to subtract 14 from last_deposit 
      #to get it into negative index format
      #and then take the opposite for the adjacent spot 
      #on player1's side of the board 
      @board[0] += @board[-1 * (last_deposit - 14)]
      @board[-1 * (last_deposit - 14)] = []
     end
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
  puts "Choose a non-empty slot from #{@player1 ? '1-6' : '8-13'}"
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
  #win method
  #board draw method/methods 
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
my_mancala = Mancala.new
my_mancala.play




