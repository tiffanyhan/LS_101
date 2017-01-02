# EASY 2 

# 1. 

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }
ages.include?("Spot")
ages.has_key?("Spot")
ages.key?("Spot")

# 2.

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }
sum = ages.values.inject(:+)
puts sum

# 3.

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }
ages.select! { |_, v| v < 100 }
puts ages

# 4.

munsters_description = "The Munsters are creepy in a good way."
puts munsters_description.capitalize
puts munsters_description.swapcase
puts munsters_description.downcase
puts munsters_description.upcase

# 5.

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10 }
additional_ages = { "Marilyn" => 22, "Spot" => 237 }
ages.merge!(additional_ages)
p ages

# 6.

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }
puts ages.values.min

# 7.

advice = "Few things in life are as important as house training your pet dinosaur."
puts advice.include?("Dino")

# 8.

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
puts flintstones.index { |item| item.start_with?("Be") }

# 9.

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
flintstones.map! do |name|
  name[0, 3]
end
p flintstones

# 10.

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
flintstones.map! { |name | name[0, 3] }
p flintstones
