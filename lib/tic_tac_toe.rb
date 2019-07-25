# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# code your input_to_index and move method here!
def input_to_index(num)
  num = num.to_i - 1
end

def move(board, num, player)
  board[num] = player
end

def position_taken?(board, num)
  board[num] == "X" || board[num] == "O"
end

def valid_move?(board, num)
  !position_taken?(board, num) && num.between?(0, 8)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    player = current_player(board)
    move(board, index, player)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  board.count("X") + board.count("O")
  # board.count {|token| token == "X" || token == "O"}
end

def current_player(board)
  turn_count(board).odd? ? "O" : "X"
end

def won?(board)
  WIN_COMBINATIONS.find do |win_array|
    win_array.all? {|i| board[i] == "X"} || win_array.all? {|i| board[i] == "O"}
  end
end

def full?(board)
  board.none? {|i| i == " "}
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || full?(board) || draw?(board)
end

def winner(board)
  if won?(board).kind_of?(Array)
    board[won?(board)[0]]
  end
end

def play(board)
  # while !over?(board)
  #   turn(board)
  # end

  turn(board) until over?(board)

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
