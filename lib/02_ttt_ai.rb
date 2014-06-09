require '06_tic_tac_toe.rb'
require '07_tic_tac_toe_node.rb'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    node = TicTacToeNode.new(game.board, mark)
    possible_moves = node.children.shuffle
    
    node = possible_moves.find { |child| child.winning_node?(mark) }
    return node.prev_move_pos if node
    
    node = possible_moves.find { |child| !child.losing_node?(mark) }
    return node.prev_move_pos if node
    
    raise "no no-losing nodes!"
  end
end

if __FILE__ == $PROGRAM_NAME
  game = TicTacToe.new(HumanPlayer.new('Marco'), SuperComputerPlayer.new)
  game.run
end