extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var score_label: Label = $UI/ScoreLabel
@onready var start_overlay: Control = $UI/StartOverlay
@onready var start_button: Button = $UI/StartOverlay/CenterContainer/PanelContainer/MarginContainer/VBoxContainer/StartButton
@onready var close_button: Button = $UI/StartOverlay/CenterContainer/PanelContainer/MarginContainer/VBoxContainer/CloseButton

func _ready() -> void:
	Global.reset_game()
	start_button.pressed.connect(_on_start_pressed)
	close_button.pressed.connect(_on_close_pressed)
	start_overlay.visible = true

func _process(delta: float) -> void:
	if Global.game_started:
		score_label.text = "Score: %d" % Global.score
		start_overlay.visible = false
	else:
		start_overlay.visible = true

func _on_start_pressed() -> void:
	Global.start_game()

func _on_close_pressed() -> void:
	get_tree().quit()