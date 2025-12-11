extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var score_label: Label = $UI/ScorePanel/MarginContainer/VBoxContainer/ScoreLabel
@onready var progress_label: Label = $UI/ProgressPanel/MarginContainer/VBoxContainer/ProgressLabel
@onready var start_overlay: Control = $UI/StartOverlay
@onready var start_button: Button = $UI/StartOverlay/CenterContainer/PanelContainer/MarginContainer/VBoxContainer/StartButton
@onready var close_button: Button = $UI/StartOverlay/CenterContainer/PanelContainer/MarginContainer/VBoxContainer/CloseButton

const TOTAL_DISTANCE: float = 2550.0  # From start (650) to goal (-1900)
var start_position: float = 650.0

func _ready() -> void:
	Global.reset_game()
	start_button.pressed.connect(_on_start_pressed)
	close_button.pressed.connect(_on_close_pressed)
	start_overlay.visible = true
	
	# Add button hover effects
	start_button.mouse_entered.connect(_on_start_button_hover)
	close_button.mouse_entered.connect(_on_close_button_hover)

func _process(delta: float) -> void:
	if Global.game_started:
		score_label.text = str(Global.score)
		
		# Calculate progress percentage
		var distance_traveled = start_position - player.position.y
		var progress = clamp((distance_traveled / TOTAL_DISTANCE) * 100.0, 0.0, 100.0)
		progress_label.text = "%d%%" % int(progress)
		
		start_overlay.visible = false
	else:
		start_overlay.visible = true

func _on_start_pressed() -> void:
	Global.start_game()
	# Animate button press
	var tween = create_tween()
	tween.tween_property(start_button, "scale", Vector2(0.95, 0.95), 0.1)
	tween.tween_property(start_button, "scale", Vector2(1.0, 1.0), 0.1)

func _on_close_pressed() -> void:
	get_tree().quit()

func _on_start_button_hover() -> void:
	var tween = create_tween()
	tween.tween_property(start_button, "scale", Vector2(1.05, 1.05), 0.2)

func _on_close_button_hover() -> void:
	var tween = create_tween()
	tween.tween_property(close_button, "scale", Vector2(1.05, 1.05), 0.2)