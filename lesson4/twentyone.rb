require 'pry'

VALUES = ['2', '3', '4', '5', '6', '7', '8', '9',
          '10', 'J', 'Q', 'K', 'A'].freeze
SUITS = ['H', 'S', 'C', 'D'].freeze

TARGET = 21
DEALER_NO = 17

GAMES_IN_A_ROUND = 5

HIT_OR_STAY_PROMPT = "Would you like to (h)it or (s)tay?".freeze
PLAY_AGAIN_PROMPT = "Five games to win a round. Would you like to play again?"\
                    " (y to continue the round, n to leave the round)".freeze
END_ROUND_PROMPT = "Would you like to start a new round? (y or n)".freeze

INVALID_ANSWER_PROMPT = "Sorry, that's not a valid answer.".freeze

PLAYERS = ['Player', 'Dealer'].freeze

def prompt(msg)
  puts "=> #{msg}"
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

def initialize_deck
  SUITS.product(VALUES).shuffle
end

def deal_cards!(deck, player_cards, dealer_cards)
  2.times do
    player_cards << deck.pop
    dealer_cards << deck.pop
  end
end

def display_initial_deal(player_cards, dealer_cards)
  player_total = total(player_cards)
  prompt "You have: #{player_cards[0]} and #{player_cards[1]}"\
       " for a total of #{player_total}"
  prompt "Dealer has: #{dealer_cards[0]} and ?"
  player_total
end

def total(cards)
  sum = 0
  # cards: [["H", "10"], ["D", "3"]]
  cards.each do |card|
    sum += if card.last == 'A'
             11
           elsif card.last.to_i.zero?
             10
           else
             card.last.to_i
           end
  end

  # correct for aces
  aces = cards.select { |card| card.include?('A') }
  aces.length.times { |_| sum -= 10 if sum > TARGET }

  sum
end

def hit!(deck, cards)
  cards << deck.pop
end

def busted?(total)
  total > TARGET
end

def player_does_turn(deck, player_cards, player_initial_total)
  player_total = nil
  loop do
    answer = validate_answer(HIT_OR_STAY_PROMPT, ['h', 's'])
    if answer == 'h'
      hit!(deck, player_cards)
      prompt "You hit!"
      player_total = total(player_cards)
      prompt "You have: #{player_cards} for a total of #{player_total}"
    end
    break if answer == 's' || busted?(player_total)
  end
  !player_total ? player_initial_total : player_total
end

def dealer_does_turn(deck, dealer_cards)
  dealer_total = nil
  loop do
    dealer_total = total(dealer_cards) if !dealer_total
    break if dealer_total >= DEALER_NO
    hit!(deck, dealer_cards)
    prompt "Dealer hit!"
    dealer_total = total(dealer_cards)
    prompt "Dealer has: #{dealer_cards} for a total of #{dealer_total}"
  end
  dealer_total
end

def display_final_cards(player_cards, dealer_cards,
                        player_total, dealer_total)
  prompt "You have: #{player_cards} for a total of #{player_total}"
  prompt "Dealer has: #{dealer_cards} for a total of #{dealer_total}"
end

def display_busted_result(loser, player_total, dealer_total,
                          player_cards, dealer_cards)
  winner = PLAYERS.select { |player| player != loser }.first
  prompt "#{loser == 'Player' ? 'You' : 'Dealer'} busted!"
  display_final_cards(player_cards, dealer_cards,
                      player_total, dealer_total)
  prompt "#{winner == 'Player' ? 'You' : 'Dealer'} won!"
end

def detect_result(player_total, dealer_total)
  if player_total > dealer_total
    :player
  elsif dealer_total > player_total
    :dealer
  else
    :tie
  end
end

def display_result(player_cards, dealer_cards,
                   player_total, dealer_total, score)
  display_final_cards(player_cards, dealer_cards,
                      player_total, dealer_total)

  result = detect_result(player_total, dealer_total)
  case result
  when :player
    increment_score!('Player', score)
    prompt "You win!"
  when :dealer
    increment_score!('Dealer', score)
    prompt "Dealer wins!"
  when :tie
    prompt "It's a tie!"
  end
end

def increment_score!(winner, score)
  score[winner] += 1
end

def display_score(score)
  prompt "Your score: #{score['Player']}, Dealer score: #{score['Dealer']}"
end

def play_again?(answer)
  answer == 'y'
end

loop do
  score = { 'Player' => 0, 'Dealer' => 0 }

  while score.values.max < GAMES_IN_A_ROUND

    deck = initialize_deck
    player_cards = []
    dealer_cards = []

    deal_cards!(deck, player_cards, dealer_cards)
    player_initial_total = display_initial_deal(player_cards, dealer_cards)

    player_total = player_does_turn(deck, player_cards, player_initial_total)

    if busted?(player_total)
      increment_score!('Dealer', score)
      dealer_total = total(dealer_cards)
      display_busted_result('Player', player_total, dealer_total,
                            player_cards, dealer_cards)
      display_score(score)

      answer = validate_answer(PLAY_AGAIN_PROMPT, ['y', 'n'])
      play_again?(answer) ? next : break
    end

    prompt "You stayed."
    prompt "Dealer turn..."

    dealer_total = dealer_does_turn(deck, dealer_cards)

    if busted?(dealer_total)
      increment_score!('Player', score)
      display_busted_result('Dealer', player_total, dealer_total,
                            player_cards, dealer_cards)
      display_score(score)

      answer = validate_answer(PLAY_AGAIN_PROMPT, ['y', 'n'])
      play_again?(answer) ? next : break
    end

    prompt "Dealer stayed."
    display_result(player_cards, dealer_cards,
                   player_total, dealer_total, score)
    display_score(score)

    answer = validate_answer(PLAY_AGAIN_PROMPT, ['y', 'n'])
    break unless play_again?(answer)
  end

  answer = validate_answer(END_ROUND_PROMPT, ['y', 'n'])
  break unless play_again?(answer)
end

prompt "Thank you for playing TwentyOne!"
