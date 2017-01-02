# HARD 1

# 1.  

# error bc the if block is not run

# 2.

# prints "hi there"

# 3.

def mess_with_vars(one, two, three)
  one = two
  two = three
  three = one
end

one = "one"
two = "two"
three = "three"

mess_with_vars(one, two, three)

puts "one is: #{one}" # prints "one"
puts "two is: #{two}" # prints "two"
puts "three is: #{three}" # prints "three"

def mess_with_vars(one, two, three)
  one = "two"
  two = "three"
  three = "one"
end

one = "one"
two = "two"
three = "three"

mess_with_vars(one, two, three)

puts "one is: #{one}" # prints "one"
puts "two is: #{two}" # prints "two"
puts "three is: #{three}" # prints "three"

def mess_with_vars(one, two, three)
  one.gsub!("one","two")
  two.gsub!("two","three")
  three.gsub!("three","one")
end

one = "one"
two = "two"
three = "three"

mess_with_vars(one, two, three)

puts "one is: #{one}" # prints "one"
puts "two is: #{two}" # prints "two"
puts "three is: #{three}" # prints "three"

# 4.
def generate_uuid
  hex_arr = ("0".."9").to_a << ("a".."f").to_a
  hex_arr.flatten!

  uuid = ""
  uuid_sections = [7, 11, 15, 19]
  32.times do |i|
    uuid << hex_arr.sample
    uuid << "-" if uuid_sections.include?(i)
  end

  uuid
end

puts generate_uuid

# 5.

def dot_separated_ip_address?(input_string)
  dot_separated_words = input_string.split(".")
  return false unless dot_separated_words.size == 4

  while dot_separated_words.length > 0 do
    word = dot_separated_words.pop
    return false unless is_an_ip_number?(word)
  end
  
  true
end

puts dot_separated_ip_address?("10.4.5.11")
puts dot_separated_ip_address?("4.5.5")
puts dot_separated_ip_address?("1.2.3.4.5")