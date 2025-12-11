extends Node

var score: int = 0
var game_started: bool = false

func add_score(points: int) -> void:
	score += points

func reset_score() -> void:
	score = 0

func start_game() -> void:
	game_started = true
	reset_score()

func reset_game() -> void:
	game_started = false
	score = 0