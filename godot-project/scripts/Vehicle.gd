extends Area2D

@export var speed: float = 300.0
@export var direction: int = 1  # 1 for right, -1 for left

@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	
	# Flip sprite if moving left
	if direction < 0:
		sprite.flip_h = true

func _process(delta: float) -> void:
	if not Global.game_started:
		return
	
	position.x += speed * direction * delta
	
	# Remove if off screen
	if position.x > 900 or position.x < -100:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player" and body.has_method("die"):
		body.die()
		get_tree().change_scene_to_file("res://scenes/DefeatScreen.tscn")