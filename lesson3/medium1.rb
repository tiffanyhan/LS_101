# MEDIUM 1

# 1.

10.times do |i|
  puts (" " * i) + "The Flinstones Rock!"
end

# 2.

statement = "The Flintstones Rock"

result = {}
letters = ('A'..'Z').to_a + ('a'..'z').to_a

letters.each do |letter|
  letter_frequency = statement.count(letter)
  result[letter] = letter_frequency if letter_frequency > 0
end

p result

# 3.

# ruby doesn't know how to add two things together of different types
# - convert the integers to strings
# - use string interpolation

# 4.

# we don't get the output we expect

numbers = [1, 2, 3, 4]

# returns 1 and 3
numbers.each_with_index do |number, index|
  p "#{index} #{numbers.inspect} #{number}"
  numbers.shift(1)
end

# returns 1 and 2
numbers = [1, 2, 3, 4]
numbers.each_with_index do |number, index|
  p "#{index} #{numbers.inspect} #{number}"
  numbers.pop(1)
end

# 5.

def factors(number)
  dividend = number
  divisors = []

  while dividend > 0
    divisors << number / dividend if number % dividend == 0
    dividend -= 1
  end
  divisors
end

p factors(16)
p factors(0)
p factors(-16)

# to see the if the number divides evenly (I.E. is a factor)
# returns all the factors

# 6.

def rolling_buffer1(buffer, max_buffer_size, new_element)
  buffer << new_element
  buffer.shift if buffer.size >= max_buffer_size
  buffer
end

def rolling_buffer2(input_array, max_buffer_size, new_element)
  buffer = input_array + [new_element]
  buffer.shift if buffer.size >= max_buffer_size
  buffer
end

# in 1, the buffer IS the argument inputted into the method
# in 2, the buffer is a copy made from the original input_array

# 7.

def fib(first_num, second_num, limit)
  while second_num < limit
    sum = first_num + second_num
    first_num = second_num
    second_num = sum
  end
  sum
end

result = fib(0, 1, 15)
puts "result is #{result}"

# a method can only access arguments given to it
# to fix, add an extra argument to the method and pass it in

# 8.

def titleize(str)
  str.split.map! { |word| word.capitalize }.join(" ")
end

puts titleize("the flinstones rock")

# 9.

munsters = {
  "Herman" => { "age" => 18, "gender" => "male" },
  "Lily" => { "age" => 18, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 17, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

# a kid is in the age range 0 - 17, 
# an adult is in the range 18 - 64,
# and a senior is aged 65+.

munsters.each do |_, v|
  case v["age"]
  when 0..17
    v["age_group"] = "kid"
  when 18..64
    v["age_group"] = "adult"
  else
    v["age_group"] = "senior"
  end
end

p munsters