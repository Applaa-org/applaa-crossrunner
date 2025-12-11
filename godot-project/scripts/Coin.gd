extends Area2D

@export var value: int = 10

var time: float = 0.0
var base_position: Vector2 = Vector2.ZERO

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	base_position = position
	
	# Add spawn animation
	scale = Vector2.ZERO
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_BACK)
	tween.tween_property(self, "scale", Vector2.ONE, 0.5)

func _process(delta: float) -> void:
	time += delta * 3.0
	# Floating animation
	position.y = base_position.y + sin(time) * 5.0
	# Subtle rotation
	rotation = sin(time * 0.5) * 0.2

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Global.add_score(value)
		
		# Collect animation
		var tween = create_tween()
		tween.set_parallel(true)
		tween.tween_property(self, "scale", Vector2(1.5, 1.5), 0.2)
		tween.tween_property(self, "modulate:a", 0.0, 0.2)
		tween.tween_callback(queue_free)