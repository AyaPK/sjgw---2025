class_name Level extends Node2D

@onready var obstacles_container: Node2D = $ObstaclesContainer
@onready var obstacle_spawn: Marker2D = $Marker2D
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
		flat.global_position.y = obstacle_spawn.global_position.y
		posx += 200

func add_flat_ground():
		var flat = FLAT_GROUND.instantiate()
		obstacles_container.add_child(flat)
		var level: Level = get_tree().get_first_node_in_group("level")
		flat.global_position = obstacle_spawn.global_position
