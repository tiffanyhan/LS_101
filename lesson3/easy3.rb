# EASY 3

# 1.

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
p flintstones

# 2.
flintstones << "Dino"
p flintstones

# 3.

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
flintstones.push("Dino", "Hoppy")
p flintstones

# 4.

advice = "Few things in life are as important as house training your pet dinosaur."
puts advice.slice!(0, advice.index('house'))
puts advice

# 5.

statement = "The Flintstones Rock!"
puts statement.count("t")

# 6.

title = "Flintstone Family Members"
puts title.center(40)