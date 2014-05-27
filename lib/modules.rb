module DrawBoard 

  def draw_board
    puts "\e[H\e[2J\n"  

    slot_0 = @board[0].join("")
    slot_1 = @board[1].join("")
    slot_2 = @board[2].join("")
    slot_3 = @board[3].join("")
    slot_4 = @board[4].join("")
    slot_5 = @board[5].join("")
    slot_6 = @board[6].join("")
    slot_7 = @board[7].join("")
    slot_8 = @board[8].join("")
    slot_9 = @board[9].join("")
    slot_10 = @board[10].join("")
    slot_11 = @board[11].join("")
    slot_12 = @board[12].join("")
    slot_13 = @board[13].join("")
    


puts <<-DRAWBOARD
                                        MATT'S MANCALA
            Instructions: http://boardgames.about.com/cs/mancala/ht/play_mancala.htm


P2 Slots 13-8

\s\s13(#{slot_13}     )\s\s\s12(#{slot_12}      )\s\s\s11(#{slot_11}     )\s\s\s10(#{slot_10}      )\s\s\s9(#{slot_9}      )\s\s\s8(#{slot_8}      )



\t\tP2Goal(#{slot_0}           )\t\t\t\t(#{slot_7}            )P1Goal



\s\s1(#{slot_1}      )\s\s\s\s2(#{slot_2}      )\s\s\s\s3(#{slot_3}      )\s\s\s4(#{slot_4}      )\s\s\s5(#{slot_5}      )\s\s\s6(#{slot_6}      )  

P1 Slots 1-6

#{collect_pebbles ? "You deposited your last pebble in an empty slot on your side.\nYou get all of the pebbles in the adjacent slot on your oppoenent's side!" : ""}
#{extra_turn ? "You deposited your last pebble in your goal.\nYou get an extra turn!" : ""}

DRAWBOARD

#can't get collect_pebbles to print message to screen when true 






end 


end 