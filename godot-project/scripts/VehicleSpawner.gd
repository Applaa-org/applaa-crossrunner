extends Node2D

@export var vehicle_scene: PackedScene
@export var spawn_interval: float = 0.8  # Much more frequent!
@export var spawn_position: Vector2 = Vector2.ZERO
@export var direction: int = 1
@export var min_speed: float = 350.0  # Much faster!
@export var max_speed: float = 550.0

var timer: float = 0.0

func _ready() -> void:
	timer = randf_range(0.0, spawn_interval * 0.5)

func _process(delta: float) -> void:
	if not Global.game_started:
		return
	
	timer += delta
	
	if timer >= spawn_interval:
		spawn_vehicle()
		timer = 0.0
		# Add variation to spawn timing
		spawn_interval = randf_range(0.6, 1.2)

func spawn_vehicle() -> void:
	if vehicle_scene:
		var vehicle = vehicle_scene.instantiate()
		vehicle.position = spawn_position
		vehicle.speed = randf_range(min_speed, max_speed)
		vehicle.direction = direction
		get_parent().add_child(vehicle)