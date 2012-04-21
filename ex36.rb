def prompt()
  print "> "
end

#  Defining global arrays for ferret stashes and things ferret player can find.
$toys_list = ['mousie', 'jingle bell', 'crinkle ball', 'kong', 'barking dog', 'fleece ball', 'stuffed bear', 'stinky sock', 'TP tube']
$sofa_stash = Array.new
puts "Sofa stash has the following: #{$sofa_stash}."
$tv_stash = Array.new
$bed_stash = Array.new  

def stash(thing) 
  puts "Where ya gonna stash that?"

  prompt; next_move3 = gets.chomp()

  if next_move3.include? "sofa"
    $sofa_stash.push thing
    puts "Sofa stash has the following: #{$sofa_stash}."
    living_room()
  elsif next_move3.include? "tv"
    $tv_stash.push thing
    living_room()
  else 
    lose("You're confused--that's no hiding place.")
  end
end
        

def sofa
  puts "The sofa has exciting toys under it, and looks easily climbable."
  puts "Do you climb on top of the sofa, or go underneath it?"

  prompt; next_move = gets.chomp()

  if next_move.include? "climb"
    puts "You can see the knitting bag next to the sofa.  It has exciting balls of yarn."
    puts "Do you hop in the knitting bag, just steal a ball of yarn, or tunnel under the sofa cushions?"

    prompt; next_move2 = gets.chomp

    if next_move2.include? "hop in"
      lose("OW OW OW!!! Impaled by a knitting needle.  You're headed for the vet.")
    elsif next_move2.include? "tunnel under"
      lose("Yawn.  What a great place for a nap.  Bet those humans never find you there.")
    elsif next_move2.include? "steal"
      thing = "yarn_ball"
      stash(thing)
    else
      lose("Try typing with your nose.  Maybe you'll make more sense.")
    end
    
  elsif next_move.include? "under"
    puts "There are some toys under the sofa already, including #{$sofa_stash}."
    incomplete_code()
  end
end
    
  

def tv_stand()
  puts "The TV stand has shelves of CDs and DVDs and equipment with wires."
  puts "Do you climb on the TV stand or go somewhere else?"

  prompt; next_move = gets.chomp

  if next_move.include? "climb"
    puts "So much havoc to wreak!  What to do first?"
    puts "Do you knock down CDs and DVDs or chew on wires?"

    prompt; next_move2 = gets.chomp

    if next_move2.include? "knock down"
     puts "Knocking down CDs and DVDs is so exciting you war dance your way to the middle of the room!"
     living_room()
    elsif next_move2.include? "chew"
      lose("Zap! It may be low voltage, but it still blisters.  You're headed for the vet.")
    else
      lose("What, are you typing with your *tail*?")
    end

  elsif next_move.include? "go"
    living_room()
  else
    lose("Dude, your choices weren't that hard.  No one was asking you to spell adrenal disease.")
  end
end

def living_room()
  puts "You can see a TV stand, a sofa and a coffee table, and the cage you were first in."
#  puts "On the floor there is a mousie, a jingle ball and a kong."  # later rev these will be %s and randomized.
  puts "The dining room is adjacent to the living room, but you can't see it well."
  puts "There is a hall leading away from the living and dining rooms."
  puts "Where do you go?"

  prompt; next_move = gets.chomp

   if next_move.include? "TV stand"
     tv_stand()
#     incomplete_code()
  elsif next_move.include? "tv stand"
     tv_stand()
#     incomplete_code()
  elsif next_move == "sofa"
    sofa()
#    incomplete_code()
  elsif next_move == "coffee table"
#    coffee_table()
     incomplete_code()
  elsif next_move == "dining room"
#    dining_room()
     incomplete_code()
  elsif next_move == "hall"
#    hall()
     incomplete_code()
  else 
    lose("Your answer made no sense.")
  end
end

def incomplete_code()
  puts "Oops!  The code monkey is still working on this section."
  puts "Have a little 'tone and mellow out."
  Process.exit(0)
end 

def lose(why)
  puts "#{why}  No war dancing for you!"
  Process.exit(0)
end

def load_stash(stash)
  3.times do
    $toys_list = $toys_list.shuffle
    toy = $toys_list.pop
    puts "toy is #{toy}."
    stash.push toy
    stash = stash.compact
    puts "The stash now has #{stash}."
  end
end

def start()
# Randomly distribute toys to the different stashes.

load_stash($sofa_stash)
load_stash($tv_stash)
load_stash($bed_stash)

puts "Sofa stash has the following: #{$sofa_stash}."
puts "Bed stash has the following: #{$bed_stash}."
puts "TV stash has the following: #{$tv_stash}."

  puts "You are in a cage."
  puts "Someone has left the door open."
  puts "Do you hop out of the door or stay in the cage?"

  prompt; next_move = gets.chomp

  if next_move.include? "hop out"
    living_room()
  elsif next_move.include? "stay"
    lose("You stay in the cage until your human spots the open door and closes it.")
  else
  puts "I can't understand what you typed."
    lose("Maybe you should get a real ferret to type your answers.")
  end
end

start()
