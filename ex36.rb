def prompt()
  print "> "
end

# Lets player/ferret choose where to hide/stash a thing.
def stash(thing) 
  puts "Where ya gonna hide that?"

  prompt; next_move3 = gets.chomp()

  if next_move3.include? "q"
    lose("You decided to quit.")
  elsif next_move3.include? "sofa"
    $sofa_stash.push thing
    puts "Sofa stash has the following: #{$sofa_stash.join(", ")}."
    where_do_you_go()
  elsif next_move3.include? "tv"
    $tv_stash.push thing
    puts "OK, now under the TV, you can see #{$tv_stash.join(", ")}."
    where_do_you_go()
  elsif $typo < $typo_max
    $typo += 1
    stash(thing)
  else 
    lose("You're confused--that's no hiding place.")
  end
end

# Handles stealing an item from a stash.
def steal_thing(pile)
#  puts "In the pile of stuff is #{pile.join(", ")}."
  puts "What will you steal?"

  prompt; thing = gets.chomp()

  if pile.include? "q"
    lose("You decided to quit.")
  elsif pile.include? thing
    puts "OK, you can steal that."    
    pile.keep_if {|element| element != thing}  #  Hmmm, looks like I could do this with pile.delete(thing).  Duh.
    if pile.empty?
      puts "There's nothing left there now."
    else
     puts "The things left there now include #{pile.join(", ")}."
    end
    stash(thing)
  elsif $typo < $typo_max
    $typo += 1
    steal_thing(pile)
  else
    lose("Sheep!")
  end
end

# Decision making on top of coffee table:
def coffee_table()
  puts "Next to you is #{$table_stuff.join(", ")}."
  puts "Will you steal something?"

  prompt; next_move = gets.chomp()
  
  if next_move.include? "q"
    lose("You decided to quit.")
  elsif next_move.include? "y"
    steal_thing($table_stuff)
  else
    puts "You can see a TV stand, a sofa and the cage you were first in."
    puts "The dining room is adjacent to the living room, but you can't see it well."
    puts "There is a hall leading away from the living and dining rooms."
    where_do_you_go()
  end
end

#Decision making under the sofa:
def under_sofa()
puts "There are some toys under the sofa, including #{$sofa_stash.join(", ")}."
puts "Do you want to steal any of those toys?"

  prompt; next_move = gets.chomp()

  if next_move.include? "q"
    lose("You decided to quit.")
  elsif next_move.include?  "y"
    steal_thing($sofa_stash)
  else
    where_do_you_go()
  end
end
        
# Decision making w/r/t sofa:
def sofa()
  puts "The sofa has exciting toys under it, and looks easily climbable."
  puts "Do you climb on top of the sofa, or go underneath it?"

  prompt; next_move = gets.chomp()

  if next_move.include? "q"
    lose("You decided to quit.")
  elsif next_move.include? "climb"
    puts "You can see the knitting bag next to the sofa.  It has exciting balls of knitting supplies."
    puts "Do you hop in the knitting bag, try to steal a ball of yarn, or tunnel under the sofa cushions?"
    puts "Or do you jump to the coffee table?"

    prompt; next_move2 = gets.chomp

    if next_move2.include? "q"
      lose("You decided to quit.")
    elsif next_move2.include? "hop in"
      lose("OW OW OW!!! Impaled by a knitting needle.  You're headed for the vet.")
    elsif next_move2.include? "tunnel under"
      lose("Yawn.  What a great place for a nap.  Bet those humans never find you there.")
    elsif next_move2.include? "steal"
      if $yarn_balls > 0 
        $yarn_balls -= 1
        thing = "yarn_ball"
        stash(thing)
      else
        puts "Nothing to steal here."
      end
    elsif next_move2.include? "coffee table" or next_move2.include? "jump"
      puts "An exciting leap lands you on top of the coffee table."
      coffee_table()
    elsif $typo < $typo_max
      puts "Come again?"
    else
      lose("Try typing with your nose.  Maybe you'll make more sense.")
    end
      
  elsif next_move.include? "under"
    under_sofa()
  elsif $typo < $typo_max
    $typo += 1
    puts "That made no sense."
    sofa()
  else
    lose("Are there actual ferrets running across the keyboard?  Because that could explain this.")
  end
end

# Decision making under the entertainment center
def under_tv_stand()
  puts "There are some toys under the TV stand, including #{$tv_stash.join(", ")}."
  puts "Do you want to steal any of those toys?"

  prompt; next_move = gets.chomp()

  if next_move.include? "q"
    lose("You decided to quit.")
  elsif next_move.include?  "y"
    steal_thing($tv_stash)
  else
    where_do_you_go()
  end 
end
    
# Decision making w/r/t the entertainment center:
def tv_stand()
  puts "The TV stand has shelves of CDs and DVDs and equipment with wires."
  puts "Under the TV stand you see #{$tv_stash.join(", ")}."
  puts "Do you climb on the TV stand, crawl under it, or go somewhere else?"

  prompt; next_move = gets.chomp

  if next_move.include? "q"
    lose("You decided to quit.")
  elsif next_move.include? "climb"
    puts "So much havoc to wreak!  What to do first?"
    puts "Do you knock down CDs and DVDs or chew on wires?"

    prompt; next_move2 = gets.chomp

    if next_move2.include? "q"
      lose("You decided to quit.")
    elsif next_move2.include? "knock down"
     puts "Knocking down CDs and DVDs is so exciting you war dance your way to the middle of the room!"
     living_room()
    elsif next_move2.include? "chew"
      lose("Zap! It may be low voltage, but it still blisters.  You're headed for the vet.")
    elsif $typo < $typo_max
      puts "What?"
      tv_stand()
    else
      lose("What, are you typing with your *tail*?")
    end

  elsif next_move.include? "under" or next_move.include? "crawl"
    under_tv_stand()
  elsif next_move.include? "go" or next_move.include? "somewhere else"
    living_room()
  else
    lose("Dude, your choices weren't that hard.  No one was asking you to spell adrenal disease.")
  end
end

# Code block to determine where player will go next.
def where_do_you_go
  puts "Where do you go?"

  prompt; next_move = gets.chomp

  if next_move.include? "q"
    lose("You decided to quit.")
  elsif next_move.include? "TV" or next_move.include? "tv" 
    tv_stand()
#     incomplete_code()
#  elsif next_move.include? "tv stand"
#    tv_stand()
#     incomplete_code()
  elsif next_move.include? "sofa"
    sofa()
#    incomplete_code()
  elsif next_move.include? "coffee table"
#    coffee_table()
    incomplete_code()
  elsif next_move.include? "dining"
#    dining_room()
    incomplete_code()
  elsif next_move.include? "hall"
#    hall()
    incomplete_code()
  elsif $typo < $typo_max
    $typo += 1
    puts "I didn't understand that."
    living_room()
  else
    lose("Perhaps your ferret could help you with your answers.")
  end
end

# Decision making in the living room:
def living_room()
  puts "You can see a TV stand, a sofa and a coffee table, and the cage you were first in."
#  puts "On the floor there is a mousie, a jingle ball and a kong."  # later rev these will be %s and randomized.
  puts "The dining room is adjacent to the living room, but you can't see it well."
  puts "There is a hall leading away from the living and dining rooms."
  where_do_you_go()
end

# Ends game when player/ferret falls off the edge of the world.
def incomplete_code()
  puts "Oops!  The code monkey is still working on this section."
  puts "Have a little 'tone and mellow out."
  Process.exit(0)
end 

# Ends game when player/ferret makes a bad decision (or just can't type)."
def lose(why)
  puts "#{why}  No war dancing for you!"
  Process.exit(0)
end

# Puts toys from toys_list randomly in a stash. 
def load_stash(stash)
  3.times do
    $toys_list = $toys_list.shuffle
    toy = $toys_list.pop
#    puts "toy is #{toy}."
    stash.push toy
#    stash = stash.compact
#    puts "The stash now has #{stash}."
  end
end

def init()
#  Defining global arrays for ferret stashes and things ferret player can find.
$toys_list = ['mousie', 'jingle bell', 'crinkle ball', 'kong', 'barking dog', 'fleece ball', 'stuffed bear', 'stinky sock', 'TP tube', 'keys', 'TV remote']
$table_stuff = %w{ wiimote keys glass }
puts "Stuff on coffee table includes #{$table_stuff.join(", ")}."

$sofa_stash = Array.new
$tv_stash = Array.new
$bed_stash = Array.new  
$typo_max = 3   # Set maximum bad entries before player gets dumped out of game.
$typo = 0   # Initialize counter for bad input.
$yarn_balls = 2   # Number of balls of yarn in knitting basket.

# Randomly distribute toys to the different stashes.
load_stash($sofa_stash)
load_stash($tv_stash)
load_stash($bed_stash)

# puts "Sofa stash has the following: #{$sofa_stash}."
# puts "Bed stash has the following: #{$bed_stash}."
# puts "TV stash has the following: #{$tv_stash}."
# puts "You can see the following on the floor: #{$toys_list}."

end

# Set up the game and start.
def start()

  puts "You are in a cage."
  puts "Someone has left the door open."
  puts "Do you hop out of the door or stay in the cage?"

  prompt; next_move = gets.chomp

  if next_move.include? "q"
    lose("You decided to quit.")
  elsif next_move.include? "hop out" or next_move.include? "out"
    living_room()
  elsif next_move.include? "stay"
    lose("You stay in the cage until your human spots the open door and closes it.")
  elsif $typo < $typo_max
    $typo += 1
    puts "I can't understand what you typed."
    start()
  else
    lose("Please get your ferret to help you with the keyboard.")
  end
end

init()
start()
