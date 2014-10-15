class Board

  def self.transform(board)
    board.each_with_index do |row, r|
      row.chars.each_with_index do |item, i|
        board[r][i] = count_neighbors(board, r, i) if item == " "
      end
    end
  end

  private

  def self.count_neighbors(board, row, pos)
    counter = 0
    if row > 0
      counter += 1 if board[row - 1][pos] == "*"
    end
    if row < board.size - 1
      counter += 1 if board[row + 1][pos] == "*"
    end
    if pos > 0
      counter += 1 if board[row][pos - 1] == "*"
    end
    if pos < board[row].length - 1
      counter += 1 if board[row][pos + 1] == "*"
    end
    counter.to_s
  end

end