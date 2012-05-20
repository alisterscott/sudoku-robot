Feature: Sudoku

Scenario: Can work out possible values for a cell in a square
	Given a sudoku board:
	"""
	1 2 3
	4 5 6
	7 _ _
	"""
	When I analyse the board
	Then cell 2,2 can contain an 8 or a 9
	And cell 2,3 can contain an 8 or a 9