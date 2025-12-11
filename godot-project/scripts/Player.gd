extends CharacterBody2D

const SPEED: float = 150.0

@onready var sprite: Sprite2D = $Sprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var camera: Camera2D = $Camera2D

var is_alive: bool = true

func _ready() -> void:
	camera.enabled = true

func _physics_process(delta: float) -> void:
	if not is_alive or not Global.game_started:
		velocity = Vector2.ZERO
		move_and_slide()
		return
	
	# Get input direction
	var direction := Vector2.ZERO
	
	if Input.is_key_pressed(KEY_W):
		direction.y -= 1
	if Input.is_key_pressed(KEY_S):
		direction.y += 1
	if Input.is_key_pressed(KEY_A):
		direction.x -= 1
	if Input.is_key_pressed(KEY_D):
		direction.x += 1
	
	# Normalize diagonal movement
	if direction != Vector2.ZERO:
		direction = direction.normalized()
	
	velocity = direction * SPEED
	move_and_slide()
	
	# Keep player in bounds horizontally
	position.x = clamp(position.x, 30, 770)

func die() -> void:
	if is_alive:
		is_alive = false
		visible = false