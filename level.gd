extends Node2D

@onready var obstacles_container: Node2D = $ObstaclesContainer
@onready var marker_2d: Marker2D = $Marker2D
const FLAT_GROUND = preload("res://obstacles/flat_ground.tscn")

var obstacle_queue: Array = []

func _ready() -> void:
	_load_flat_ground()

func _process(delta: float) -> void:
	pass

func _load_flat_ground() -> void:
	var posx: int = 0
	for x in range(0, 5):
		var flat = FLAT_GROUND.instantiate()
		obstacles_container.add_child(flat)
		flat.global_position.x = posx
		posx += 200

func add_flat_ground():
		var flat = FLAT_GROUND.instantiate()
		obstacles_container.add_child(flat)
		flat.global_position.x = marker_2d.global_position.x

func needs_new_obstacle():
	return obstacles_container.get_child_count() > 2
