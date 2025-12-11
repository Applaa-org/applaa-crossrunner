extends Area2D

var time: float = 0.0

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _process(delta: float) -> void:
	time += delta * 2.0
	# Pulsing effect
	modulate.a = 0.7 + sin(time) * 0.3

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		# Flash effect before transition
		var tween = create_tween()
		tween.tween_property(self, "modulate", Color(1, 1, 1, 1), 0.2)
		tween.tween_callback(func(): get_tree().change_scene_to_file("res://scenes/VictoryScreen.tscn"))