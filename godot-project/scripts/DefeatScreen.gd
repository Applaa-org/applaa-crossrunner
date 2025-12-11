extends Control

@onready var score_label: Label = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/ScorePanel/MarginContainer/VBoxContainer/ScoreLabel
@onready var restart_button: Button = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/RestartButton
@onready var close_button: Button = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/CloseButton
@onready var title_label: Label = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/TitleLabel
@onready var background_glow: ColorRect = $BackgroundGlow

var time: float = 0.0

func _ready() -> void:
	score_label.text = str(Global.score)
	restart_button.pressed.connect(_on_restart_pressed)
	close_button.pressed.connect(_on_close_pressed)
	
	# Add hover effects
	restart_button.mouse_entered.connect(_on_restart_button_hover)
	close_button.mouse_entered.connect(_on_close_button_hover)
	
	# Entrance animation
	modulate.a = 0.0
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 0.5)
	
	# Title shake animation
	var shake_tween = create_tween()
	shake_tween.set_loops()
	shake_tween.tween_property(title_label, "position:x", title_label.position.x + 5, 0.1)
	shake_tween.tween_property(title_label, "position:x", title_label.position.x - 5, 0.1)
	shake_tween.tween_property(title_label, "position:x", title_label.position.x, 0.1)
	shake_tween.tween_interval(2.0)

func _process(delta: float) -> void:
	time += delta
	# Pulsing background glow
	background_glow.modulate.a = 0.2 + sin(time * 2.0) * 0.1

func _on_restart_pressed() -> void:
	var tween = create_tween()
	tween.tween_property(restart_button, "scale", Vector2(0.95, 0.95), 0.1)
	tween.tween_property(restart_button, "scale", Vector2.ONE, 0.1)
	tween.tween_callback(func():
		Global.reset_game()
		get_tree().change_scene_to_file("res://scenes/Main.tscn")
	)

func _on_close_pressed() -> void:
	get_tree().quit()

func _on_restart_button_hover() -> void:
	var tween = create_tween()
	tween.tween_property(restart_button, "scale", Vector2(1.05, 1.05), 0.2)

func _on_close_button_hover() -> void:
	var tween = create_tween()
	tween.tween_property(close_button, "scale", Vector2(1.05, 1.05), 0.2)