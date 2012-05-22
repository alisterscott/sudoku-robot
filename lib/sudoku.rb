module Sudoku

  def string_to_grid string
    string.split("\n").map { |row| row.split.map { |cell| cell } }
  end

end