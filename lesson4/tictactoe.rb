require 'pry'

WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                [[1, 5, 9], [3, 5, 7]]

INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'

MAX_SCORE = 5

def prompt(msg)
  puts "=> #{msg}"
end

def joinor(arr, conn=', ', word='or')
  case arr.length
    when 0 then ''
    when 1 then arr.first
    when 2 then arr.join(" #{word} ")
    else
      arr[-1] = "#{word} #{arr.last}"
      arr.join(conn)
    end
end

# rubocop: disable Metrics/AbcSize
def display_board(brd, score)
  system 'clear'
  puts "You're a #{PLAYER_MARKER}.  Computer is #{COMPUTER_MARKER}"
  puts "Player score: #{score['Player']}"
  puts "Computer score: #{score['Computer']}"
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts "     |     |"
  puts ""
end
# rubocop: enable Metrics/AbcSize

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def player_places_piece!(brd)
  square = ''
  loop do
    prompt "Choose a square (#{joinor(empty_squares(brd))}):"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt "Sorry, that's not a valid choice."
  end
  brd[square] = PLAYER_MARKER
end

def find_winning_square(brd, line, marker)
  if brd.values_at(*line).count(marker) == 2
    brd.select{|k,v| line.include?(k) && v == INITIAL_MARKER}.keys.first
  else
    nil
  end
end

def computer_places_piece!(brd)
  square = nil

  # offense first
  WINNING_LINES.each do |line|
    square = find_winning_square(brd, line, COMPUTER_MARKER)
    break if square
  end

  # then defense
  if !square
    WINNING_LINES.each do |line|
      square = find_winning_square(brd, line, PLAYER_MARKER)
      break if square
    end
  end

  # pick square 5 if available
  if !square
    square = 5 if empty_squares(brd).include?(5)
  end

  # just pick any square
  if !square
    square = empty_squares(brd).sample
  end

  brd[square] = COMPUTER_MARKER
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 3
      return 'Player'
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
  end
  nil
end

def show_result(board, score)
  if someone_won?(board)
    if score.values.max == MAX_SCORE
      prompt "#{detect_winner(board)} won the round!"
    else
      prompt "#{detect_winner(board)} won!"
    end
  else
    prompt "It's a tie!"
  end
end

loop do
  # start a new round
  score = {"Computer" => 0, "Player" => 0}

  while score.values.max < MAX_SCORE
    # new game in same round
    board = initialize_board

    loop do
      # start turns
      display_board(board, score)

      player_places_piece!(board)
      break if someone_won?(board) || board_full?(board)

      computer_places_piece!(board)
      break if someone_won?(board) || board_full?(board)
    end

    # show last game board
    score[detect_winner(board)] += 1 if someone_won?(board)
    display_board(board, score)

    show_result(board, score)
    # now what?
    prompt "Five games to win a round.  Play again? (y or n)"
    answer = gets.chomp
    break unless answer.downcase.start_with?('y')
  end
end

prompt "Thanks for playing Tic Tac Toe!  Goodbye!"
