# 1. a method that returns the sum of two integers

Given two integers.

Add the two integers together.

Return the sum.

~

START

SET sum = number1 + number2

PRINT sum

END

# 2. a method that takes an array of strings, and returns a 
# string that is all those strings concatenated together

Given an array of strings.

Initialize a variable for an empty string.
Iterate through each string of the array.
Add each string to the empty string variable.

Return the final string variable.

~

START

SET concat_str = empty string
SET iterator = 1

WHILE iterator < arr_of_strings
  add string to concat_str

PRINT concat_str

END

# 3. a method that takes an array of integers, and returns a 
# new array with every other element

Given an array of integers.

Initialize a new variable for an empty array.
Iterate through the collection.
  if iterator index is odd, add item to the new array
  else move on to the next value in the iterator

  iterator = iterator + 1

Return the new array.

~

START

SET every_other_arr = empty array
SET iterator = 1

while iterator < length of integers
  if iterator is odd, add integer to every_other_arr
  else go to the next iteration

  iterator = iterator + 1

END
