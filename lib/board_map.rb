class BoardMap
  BOMB_CHAR  = '*'
  EMPTY_CHAR = '.'

  def initialize(size, mines)
    @mines = mines
    @board = Array.new(size.to_i) { Array.new(size.to_i, 0) }
  end

  def to_s
    rendering_board_map
    @board.each do |row|
      row.map! { |cell| cell = cell == 0 ? EMPTY_CHAR : cell }
      row.push("\n")
    end
    @board.join
  end

  def rendering_board_map
    @mines.each do |mine|
      column, row = mine
      @board[row][column] = BOMB_CHAR

      neighboring_rows(row).each do |row|
        [column, column - 1, column + 1].each do |column|
          @board[row][column] += 1 if @board[row][column] && @board[row][column] != BOMB_CHAR
        end
      end
    end
  end

  def neighboring_rows(row)
    rows = [row]
    rows.push(row - 1) if @board[row - 1]
    rows.push(row + 1) if @board[row + 1]
    rows
  end
end
