extends Control

@onready var score_label: Label = $CenterContainer/PanelContainer/VBoxContainer/ScoreLabel
@onready var restart_button: Button = $CenterContainer/PanelContainer/VBoxContainer/RestartButton
@onready var close_button: Button = $CenterContainer/PanelContainer/VBoxContainer/CloseButton

func _ready() -> void:
	score_label.text = "Final Score: %d" % Global.score
	restart_button.pressed.connect(_on_restart_pressed)
	close_button.pressed.connect(_on_close_pressed)

func _on_restart_pressed() -> void:
	Global.reset_game()
	get_tree().change_scene_to_file("res://scenes/Main.tscn")

func _on_close_pressed() -> void:
	get_tree().quit()