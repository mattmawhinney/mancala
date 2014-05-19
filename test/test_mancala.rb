module MancalaTests 
  #my_mancala = Mancala.new
  
  

  def test_get_move
    #initializes with @player1 == true 
    my_mancala = Mancala.new
    puts
    puts "Does a valid move from player1 get stored correctly?"
    my_mancala.get_move
    puts "If so, the number you just entered should be displayed below:"
    puts my_mancala.slot 
    
    #puts my_mancala.get_move_tester(3) == my_mancla.player1 # expecting => true 
    #switch players 
    my_mancala.turn_switch 
    puts
    puts "Does a valid move from player2 get stored correctly?"
    my_mancala.get_move
    puts "If so, the number you just entered should be displayed below:"
    puts my_mancala.slot 
    puts

    #does get_move reject invalid moves



  end

  def test_get_move_and_move


    #does get move interact properly with move
    count = 0 
    my_mancala = Mancala.new
    p my_mancala.board
    while count < 10
      my_mancala.get_move
      my_mancala.move 
      puts
      p my_mancala.board
      my_mancala.turn_switch
        
      # my_mancala.clear
      count += 1 
    end 

  
  end

  def test_skip_endzone
    #for this test make sure your @board array has two empty endzones
    #and 8 pebbles in slots 6 and 13 
    #also make sure attr_accesor :board is selected above initialze
    my_mancala = Mancala.new
    show_board = my_mancala.board 
    puts 
    puts "Starting Board"
    p show_board
    puts
    puts "If Player1 moves 8 pebbles from slot 6"
    puts "does it skip, Player2's endzone?"
    my_mancala.move_tester(6)
    puts my_mancala.board[0] == []
    puts 
    p show_board
    #for testing ease set player1's endzone to an empty array pebbles 
    puts
    puts "Clearing out Player1's endzone, and switching turns"
    my_mancala.board[7] = []
    my_mancala.turn_switch
    p show_board
    puts
    puts "If Player2 moves 8 pebbles from slot 13"
    puts "does it skip, Player1's endzone?"
    my_mancala.move_tester(13)
    puts my_mancala.board[7] == []
    p my_mancala.board

  end 

  def test_extra_turn 
    #tests to see if player deposits their last pebble 
    #in their own endzone, do they get an extra turn 
    my_mancala = Mancala.new
    show_board = my_mancala.board 
    puts
    puts "Starting with Player1"
    puts my_mancala.player1
    puts 
    puts "If Player1 Chooses Slot 3,"
    puts "deposits his last stone in his endzone,"
    puts "and a turn_switch is called"
    puts "is it still Player1's turn?"
    my_mancala.move_tester(3)
    puts 
    my_mancala.turn_switch unless my_mancala.extra_turn
    puts my_mancala.player1
    puts 
    puts "The last slot deposited into is:"
    puts my_mancala.last_deposit_tracker.inspect

    puts "Now Player2"
    my_mancala.player1 = false
    my_mancala.player2 = true
    puts 
    puts "Player1"
    puts my_mancala.player1
    puts "Player2"
    puts my_mancala.player2
    puts
    puts "If Player2 Chooses Slot 10"
    puts "deposits his last stone in his endzone,"
    puts "and a turn_switch is called"
    puts "is it still Player2's turn?"
    my_mancala.move_tester(10)
    puts 
    my_mancala.turn_switch unless my_mancala.extra_turn
    puts my_mancala.player2
    puts 
    puts "The last slot deposited into is:"
    puts my_mancala.last_deposit_tracker.inspect
  end 

  def test_collect_pebbles
    my_mancala = Mancala.new
    puts
    puts "Emptying board at slots 6 and 13"
    puts "and putting 6 pebbles in slots 1 and 8"
    show_board = my_mancala.board
    puts 
    my_mancala.board[6] = []
    my_mancala.board[13] = []
    my_mancala.board[1] = [1,1,1,1,1,1]
    my_mancala.board[8] = [1,1,1,1,1,1]
    # puts
    # p show_board
    # puts
    # puts "If Player1 moves the pebbles in Slot2, dropping the last"
    # puts "one in slot 6, do the pebbles from slot 8"
    # puts "go into Player1's endzone?"
    # my_mancala.move_tester(2)
    # my_mancala.collect_pebbles 
    # puts
    # puts "Pebbles go to endzone?"
    # puts my_mancala.board[7].length == 6
    # puts
    # puts "Slot 8 empty?"
    # puts my_mancala.board[-6].length == 0
    # puts
    # puts "Let's see the board"
    # p show_board
    
    #player2
    my_mancala.turn_switch
    my_mancala.move_tester(9)
    my_mancala.collect_pebbles
    # puts "Player2 picks slot 9"
    # puts "Let's see it"
    # puts 
    # p show_board
    # puts
    # puts "Last Deposit"
    # puts my_mancala.last_deposit
    # puts my_mancala.board[my_mancala.last_deposit]
    # puts 
    # puts "Call collect pebbels"
    
    # puts 
    # p show_board
    # puts 

    puts
    puts "If Player2 moves the pebbles in Slot 9, dropping the last"
    puts "one in slot 13, do the pebbles from slot 1"
    puts "go into Player2's endzone?"
    puts
    puts "Pebbles go to endzone?"
    puts my_mancala.board[0].length == 6
    puts
    puts "Slot 1 empty?"
    puts my_mancala.board[1].length == 0
    puts
    puts "Let's see the board"
    p show_board

  
  end 

  def test_game_over
    #player 1, slots 1-6 
    my_mancala = Mancala.new
    puts
    puts "Emptying board at slots 1-5"
    show_board = my_mancala.board
    puts 
    my_mancala.board[1] = []
    my_mancala.board[2] = []
    my_mancala.board[3] = []
    my_mancala.board[4] = []
    my_mancala.board[5] = []
    puts 
    puts "Board"
    p show_board
    puts 
    puts "If player1 clears Slot 6"
    puts "Does it end the game?"
    puts
    my_mancala.move_tester(6)
    puts my_mancala.game_over

    #slots 8-13
    my_mancala.turn_switch
    puts
    puts "Emptying board at slots 8-12"
    puts "and adding pebbles back to slot 1"

    my_mancala.board[8] = []
    my_mancala.board[9] = []
    my_mancala.board[10] = []
    my_mancala.board[11] = []
    my_mancala.board[12] = []
    my_mancala.board[1] = [1,1,1,1]

    puts 
    puts "Board"
    p show_board
    puts 
    puts "If player2 clears Slot 13"
    puts "Does it end the game?"
    puts
    my_mancala.move_tester(13)
    puts my_mancala.game_over


  end 

  def test_win 
    my_mancala = Mancala.new
    my_mancala.board[0] = [1,1,1,1]
    my_mancala.board[7] = [1,1]
    puts 
    puts "If Player2 has more in his endzone"
    puts "does he win?"
    my_mancala.win
    puts
    my_mancala.board[0] = [1,1]
    my_mancala.board[7] = [1,1,1,1]
    puts 
    puts "If Player1 has more in his endzone"
    puts "does he win?"
    my_mancala.win
    puts
    my_mancala.board[0] = [1,1]
    my_mancala.board[7] = [1,1]
    puts 
    puts "If Player1 and Player2 have the same amount"
    puts "is it a draw?"
    my_mancala.win


  end 


  def test_move_valid?
    #initializes with @player1 = true, @player2 = false 
    my_mancala = Mancala.new
    #show board
    puts 
    puts "#{my_mancala.player1 ? 'Player1' : 'Player2'}"
    puts "Choose Slot 0"
    puts "Move Valid?"
    #slot is empty and outside player's range  
    my_mancala.get_move(0)
    puts my_mancala.move_valid? # expecting => false 
    puts 
    puts "#{my_mancala.player1 ? 'Player1' : 'Player2'}"
    puts "Choose Slot 3"
    puts "Move Valid?"
    #@player1 = true & slot is between 1-6  
    my_mancala.get_move(3)
    puts my_mancala.move_valid? # expecting => true 
    # make the move, which clears slot 3 
    my_mancala.move_tester(3)
    puts 
    puts "#{my_mancala.player1 ? 'Player1' : 'Player2'}"
    puts "Choose Slot 3 Again"
    puts "Move Valid?"
    # length of array at slot 3 now == 0 
    my_mancala.get_move(3)
    puts my_mancala.move_valid? # expecting => false
    puts 
    puts "#{my_mancala.player1 ? 'Player1' : 'Player2'}"
    puts "Choose Slot 12"
    puts "Move Valid?"
    #@player1 still true but slot choice outside 1-6 
    my_mancala.get_move(12)
    puts my_mancala.move_valid? #expecting => false

    #switch to player 2 
    my_mancala.player1 = false
    my_mancala.player2 = true 

    puts 
    puts "#{my_mancala.player1 ? 'Player1' : 'Player2'}" 
    puts "Choose Slot 10"
    puts "Move Valid?"
    #@player2 == true & slot is between 8-12  
    my_mancala.get_move(10)
    puts my_mancala.move_valid? # expecting => true 
    puts 
    puts "#{my_mancala.player1 ? 'Player1' : 'Player2'}"
    puts "Choose Slot 4"
    puts "Move Valid?"
    #@player2 == true but slot choice outside 8-12
    my_mancala.get_move(4)
    puts my_mancala.move_valid? #expecting => false

  end 

  
  def test_numeric_move 
    #on a new board, trying to deposit stones from slot 7 (empty)
    #shouldn't change length of slot 8 
    my_mancala = Mancala.new
    my_mancala.move(7)
    puts my_mancala.board[8].length == 4 
    #on a new board, moving the stones in slot 8, then slot 9
    #should leave 6 stones in slot 10 
    my_mancala = Mancala.new
    my_mancala.move(8)
    my_mancala.move(9)
    puts my_mancala.board[10].length == 6
  end

  def test_visual_move
    my_mancala = Mancala.new

    puts "In the beginning"
    p my_mancala.board
    puts
    puts "First Move"
    my_mancala.move(1)
    p my_mancala.board
    puts
    puts "Second Move"
    my_mancala.move(2)
    p my_mancala.board
    puts
    puts "Third Move"
    my_mancala.move(3)
    p my_mancala.board
    puts
    puts "Fourth Move"
    my_mancala.move(4)
    p my_mancala.board
    puts
    puts "Fifth Move"
    my_mancala.move(5)
    p my_mancala.board
    puts
    puts "Sixth Move"
    my_mancala.move(6)
    p my_mancala.board
    puts
    puts "Seventh Move"
    my_mancala.move(7)
    p my_mancala.board
    puts
    puts "Eigth Move"
    my_mancala.move(8)
    p my_mancala.board
    puts
  end 

end


