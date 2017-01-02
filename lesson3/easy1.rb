# EASY 1

# 1.

'returns [1, 2, 2, 3]'

# 2.  

# - does not equal, put it in conditionals
# - negates something
# - mutates the caller
# - ternary operator to write short conditional statements
# - checks for something, and returns T/F
# - converts something to a boolean

# 3.

advice = "Few things in life are as important as house training your pet dinosaur."
p advice.sub!('important', 'urgent')

# 4.

'delete_at deletes the value at the index position given.'
'delete deletes the value from the array.'

# 5.

puts (10..100).include?(42)

# 6.

famous_words = "seven years ago..."
famous_words.prepend "Four score and "
puts famous_words
famous_words = "seven years ago..."
puts famous_words.insert(0, "Four score and ")

# 7.

def add_eight(number)
  number + 8
end

number = 2

how_deep = "number"
5.times { how_deep.gsub!("number", "add_eight(number)") }
p eval(how_deep) # result is 42

# 8.

flintstones = ["Fred", "Wilma"]
flintstones << ["Barney", "Betty"]
flintstones << ["BamBam", "Pebbles"]
flintstones.flatten!
p flintstones

# 9.

flintstones = { "Fred" => 0, "Wilma" => 1, "Barney" => 2, "Betty" => 3, "BamBam" => 4, "Pebbles" => 5 }
p flintstones.assoc("Barney")

# 10.

flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]
f_hash = {}
flintstones.each_with_index { |item, index| f_hash[index] = item }
p f_hash
