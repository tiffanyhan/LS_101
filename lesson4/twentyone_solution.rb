SUITS = ['H', 'D', 'S', 'C'].freeze
VALUES = ['2', '3', '4', '5', '6', '7', '8', '9', '10',
          'J', 'Q', 'K', 'A'].freeze

TARGET = 21
DEALER_NO = 17

GAMES_TO_WIN_ROUND = 5

END_GAME_PROMPT = "Five games to win a round. Do you want to play again?"\
                  " (y to continue the round, n to exit the round)"
END_ROUND_PROMPT = "Do you want to start a new round?"

def prompt(msg)
  puts "=> #{msg}"
end

def initialize_deck
  SUITS.product(VALUES).shuffle
end

def initial_deal!(deck, dealer_cards, player_cards)
  2.times do
    player_cards << deck.pop
    dealer_cards << deck.pop
  end

  prompt "Dealer has #{dealer_cards[0]} and ?"
  prompt "You have: #{player_cards[0]} and #{player_cards[1]},"\
         " for a total of #{total(player_cards)}."
end

def total(cards)
  # cards = [['H', '3'], ['S', 'Q'], ... ]
  values = cards.map { |card| card[1] }

  sum = 0
  values.each do |value|
    if value == 'A'
      sum += 11
    elsif value.to_i.zero? # J, Q, K
      sum += 10
    else
      sum += value.to_i
    end
  end

  # correct for Aces
  values.select { |value| value == 'A' }.count.times do
    sum -= 10 if sum > TARGET
  end

  sum
end

def busted?(cards)
  total(cards) > TARGET
end

def detect_result(dealer_cards, player_cards)
  player_total = total(player_cards)
  dealer_total = total(dealer_cards)

  if player_total > TARGET
    :player_busted
  elsif dealer_total > TARGET
    :dealer_busted
  elsif dealer_total < player_total
    :player
  elsif dealer_total > player_total
    :dealer
  else
    :tie
  end
end

def display_result(score, dealer_cards, player_cards)
  result = detect_result(dealer_cards, player_cards)
  case result
  when :player_busted, :dealer
    increment_score!(score, 'Dealer')
    prompt "Dealer wins!"
  when :dealer_busted, :player
    increment_score!(score, 'Player')
    prompt "You win!"
  else result == :tie
    prompt "It's a tie!"
  end

  prompt "Your score: #{score['Player']}, Dealer score: #{score['Dealer']}"
end

def increment_score!(score, winner)
  score[winner] += 1
end

def display_comparison(dealer_cards, dealer_total,
                       player_cards, player_total)
  prompt "Dealer has #{dealer_cards}, for a total of: #{dealer_total}"
  prompt "Player has #{player_cards}, for a total of: #{player_total}"
end

def play_again?(type)
  case type
  when "game"
    prompt END_GAME_PROMPT
  when "round"
    prompt END_ROUND_PROMPT
  end

  answer = gets.chomp
  answer.downcase.start_with?('y')
end

loop do
  prompt "Welcome to Twenty-One!"
  score = { 'Player' => 0, 'Dealer' => 0 }

  while score.values.max < GAMES_TO_WIN_ROUND
    # initialize variables
    deck = initialize_deck
    player_cards = []
    dealer_cards = []

    initial_deal!(deck, dealer_cards, player_cards)

    # player turn
    loop do
      player_turn = nil
      loop do
        prompt "Would you like to (h)it or (s)tay?"
        player_turn = gets.chomp.downcase
        break if ['h', 's'].include?(player_turn)
        prompt "Sorry, must enter 'h' or 's'."
      end

      if player_turn == 'h'
        player_cards << deck.pop
        prompt "You chose to hit!"
        prompt "Your cards are now: #{player_cards}"
        prompt "Your total is now: #{total(player_cards)}"
      end

      break if player_turn == 's' || busted?(player_cards)
    end

    player_total = total(player_cards)
    if busted?(player_cards)
      prompt "You busted!"
      display_comparison(dealer_cards, total(dealer_cards),
                         player_cards, player_total)
      display_result(score, dealer_cards, player_cards)
      play_again?('game') ? next : break
    else
      prompt "You stayed at #{player_total}"
    end

    # dealer turn
    prompt "Dealer turn..."

    loop do
      break if busted?(dealer_cards) || total(dealer_cards) >= DEALER_NO

      prompt "Dealer hits!"
      dealer_cards << deck.pop
      prompt "Dealer's cards are now: #{dealer_cards}"
    end

    dealer_total = total(dealer_cards)
    if busted?(dealer_cards)
      prompt "Dealer busted!"
      display_comparison(dealer_cards, dealer_total,
                         player_cards, player_total)
      display_result(score, dealer_cards, player_cards)
      play_again?('game') ? next : break
    else
      prompt "Dealer stays at #{dealer_total}"
    end

    display_comparison(dealer_cards, dealer_total,
                       player_cards, player_total)
    display_result(score, dealer_cards, player_cards)
    break unless play_again?('game')
  end

  break unless play_again?('round')
end

prompt "Thank you for playing Twenty-One!  Good bye!"
