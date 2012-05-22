Feature: Sudoku

Scenario: Can work out possible values for a cell in a square group
	Given a sudoku square group:
	"""
	1 2 3
	4 5 6
	7 _ _
	"""
	When I analyse the square group
	Then cell 2,1 can contain an 8 or a 9
	And cell 2,2 can contain an 8 or a 9