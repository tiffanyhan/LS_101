# get loan amount
# get annual percentage rate (APR) - expressed in percentage or decimal?
# get loan duration - expressed in years?

# calculate monthly interest rate - divide APR by 12
# calculate loan duration in months - multiply loan duration by 12

def is_decimal?(num)
  num.include?'.'
end

# p is loan amount.  j is monthly interest rate.
# n is loan duration in months.
def calc_payment_mos(p, j, n)
  m = p * (j / (1 - (1 + j)**(-n)))
end

puts "Welcome to the mortgage calculator."

loop do
  loan_amount = ''
  loop do
    puts "What is the loan amount?"
    loan_amount = gets.chomp

    if loan_amount.empty? || loan_amount.to_f <= 0
      puts "You must enter a positive number"
    else
      break
    end
  end

  apr_decimal = ''
  loop do
    puts "What is the annual percentage rate or APR? (input as a decimal)"
    apr_decimal = gets.chomp

    if apr_decimal.empty? || apr_decimal.to_f <= 0
      puts "You must enter a positive number"
    elsif !(is_decimal?(apr_decimal))
      puts "Hmmm.. that doesn't look like a decimal."
    else
      break
    end
  end

  duration_mos = ''
  loop do
    puts "What is the loan duration? (expressed in months)"
    duration_mos = gets.chomp

    if duration_mos.empty? || duration_mos.to_i <= 0
      puts "Please enter a valid number"
    else
      break
    end
  end

  int_rate_mos = apr_decimal.to_f / 12

  m = calc_payment_mos(loan_amount.to_f, int_rate_mos, duration_mos.to_i)
  puts "Your monthly payment is $#{format('%02.2f', m)}"

  puts "Do you want to perform another calculation? (Y to calculate again)"
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

puts "Thank you for using the mortgage calculator.  Goodbye"