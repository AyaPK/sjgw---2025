class_name Level extends Node2D

@onready var obstacles_container: Node2D = $ObstaclesContainer
@onready var obstacle_spawn: Marker2D = $Marker2D
const FLAT_GROUND = preload("res://obstacles/flat_ground.tscn")
const BASIC_RAIL = preload("res://obstacles/basic_rail.tscn")

var obstacle_queue: Array = []

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func add_flat_ground():
	var flat = FLAT_GROUND.instantiate()
	obstacles_container.add_child(flat)
	var level: Level = get_tree().get_first_node_in_group("level")
	flat.global_position = obstacle_spawn.global_position

func add_basic_rail():
	var flat = BASIC_RAIL.instantiate()
	obstacles_container.add_child(flat)
	var level: Level = get_tree().get_first_node_in_group("level")
	flat.global_position = obstacle_spawn.global_position
