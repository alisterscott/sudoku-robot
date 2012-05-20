module Sudoku

  def string_to_board_grid board_string
    board_string.split("\n").map { |row| row.split.map { |cell| cell } }
  end

  def create_board board_grid_string
    Sudoku::Board.new string_to_board_grid(board_grid_string)
  end
end