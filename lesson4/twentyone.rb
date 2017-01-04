require 'pry'

VALUES = ['2', '3', '4', '5', '6', '7', '8', '9',
          '10', 'J', 'Q', 'K', 'A']
SUITS = ['H', 'S', 'C', 'D']

TARGET = 21
DEALER_NO = 17

HIT_OR_STAY_PROMPT = "Would you like to (h)it or (s)tay?"
PLAY_AGAIN_PROMPT = "Would you like to play again? (y or n)"
INVALID_ANSWER_PROMPT = "Sorry, that's not a valid answer."

def prompt(msg)
  puts "=> #{msg}"
end

def initialize_deck
  SUITS.product(VALUES).shuffle
end

def deal_cards!(deck, player_cards, dealer_cards)
  2.times do
    player_cards << deck.pop
    dealer_cards << deck.pop
  end
end

def display_hand(cards)
  prompt "You have: #{cards} for a total of #{total(cards)}"
end

def display_initial_deal(player_cards, dealer_cards)
  prompt "You have: #{player_cards[0]} and #{player_cards[1]}"\
       " for a total of #{total(player_cards)}"
  prompt "Dealer has: #{dealer_cards[0]} and ?"
end

def total(cards)
  sum = 0
  # cards: [["H", "10"], ["D", "3"]]
  cards.each do |card|
    if card.last == 'A'
      sum += 11
    elsif card.last.to_i == 0
      sum += 10
    else
      sum += card.last.to_i
    end
  end

  # correct for aces
  aces = cards.select { |card| card.include?('A') }
  aces.length.times { |_| sum -= 10 if sum > 21 }

  sum
end

def hit!(deck, cards)
  cards << deck.pop
end

def busted?(cards)
  total(cards) > 21
end

def display_final_cards(player_cards, dealer_cards)
  prompt "You have: #{player_cards} for a total of #{total(player_cards)}"
  prompt "Dealer has: #{dealer_cards} for a total of #{total(dealer_cards)}"
end

def detect_result(player_cards, dealer_cards)
  player_total = total(player_cards)
  dealer_total = total(dealer_cards)

  if player_total > dealer_total
    :player
  elsif dealer_total > player_total
    :dealer
  else
    :tie
  end
end

def display_result(player_cards, dealer_cards)
  display_final_cards(player_cards, dealer_cards)
  result = detect_result(player_cards, dealer_cards)
  case result
  when :player then prompt "You win!"
  when :dealer then prompt "Dealer wins!"
  when :tie then prompt "It's a tie!"
  end
end

def validate_answer(question, valid_answers)
  answer = ''
  loop do
    prompt question
    answer = gets.chomp.downcase
    break if valid_answers.include?(answer)
    prompt INVALID_ANSWER_PROMPT
  end
  answer
end

def play_again?(answer)
  answer == 'y'
end

loop do
  deck = initialize_deck
  player_cards = []
  dealer_cards = []

  deal_cards!(deck, player_cards, dealer_cards)
  display_initial_deal(player_cards, dealer_cards)

  # player turn
  loop do
    answer = validate_answer(HIT_OR_STAY_PROMPT, ['h', 's'])
    if answer == 'h'
      hit!(deck, player_cards)
      prompt "You hit!"
      display_hand(player_cards)
    end

    break if busted?(player_cards) || answer == 's'
  end

  if busted?(player_cards)
    prompt "You busted!"
    display_final_cards(player_cards, dealer_cards)
    prompt "Dealer wins!"

    answer = validate_answer(PLAY_AGAIN_PROMPT, ['y', 'n'])
    play_again?(answer) ? next : break
  else
    prompt "You stayed."
  end

  prompt "Dealer turn..."

  # dealer turn
  loop do
    break if total(dealer_cards) >= 17
    hit!(deck, dealer_cards)
    prompt "Dealer hit!"
    prompt "Dealer has: #{dealer_cards} for a total of #{total(dealer_cards)}"
  end

  if busted?(dealer_cards)
    prompt "Dealer busted!"
    display_final_cards(player_cards, dealer_cards)
    prompt "You win!"

    answer = validate_answer(PLAY_AGAIN_PROMPT, ['y', 'n'])
    play_again?(answer) ? next : break
  else
    prompt "Dealer stayed."
  end

  display_result(player_cards, dealer_cards)

  answer = validate_answer(PLAY_AGAIN_PROMPT, ['y', 'n'])
  break unless play_again?(answer)
end
