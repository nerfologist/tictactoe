class TicTacToeNode
  
  attr_reader :board, :next_mover_mark
  attr_accessor :prev_move_pos
  
  def initialize(board, mark)
    @board = board
    @next_mover_mark = mark
    @prev_move_pos = []
  end
  
  def children
    result = []

    3.times do |x|
      3.times do |y|
        if @board.empty?([x, y])
          new_board = @board.dup
          new_board[[x,y]] = @next_mover_mark
          node = TicTacToeNode.new(new_board, alternate_mark(@next_mover_mark))
          node.prev_move_pos = [x, y]
          result << node
        end
      end
    end
    
    result
  end
  
  def alternate_mark(mark)
    mark == :o ? :x : :o
  end
  
  def losing_node?(player)
    return @board.winner != player if @board.won?

    return false if children.empty?
    
    if self.next_mover_mark == player
      children.all? do |child|
        child.losing_node?(player)
      end
    else
      children.any? do |child|
        child.losing_node?(player)
      end
    end
  end
 
  def winning_node?(player)
    return @board.winner == player if @board.won?
    return false if children.empty?

    if self.next_mover_mark == player
      children.any? do |child|
        child.winning_node?(player)
      end
    else
      children.all? do |child|
        child.winning_node?(player)
      end
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  # n = TicTacToeNode.new(Board.new, :x)
  # n.children
end