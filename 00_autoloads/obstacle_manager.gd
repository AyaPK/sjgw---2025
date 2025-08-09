extends Node

var level: Level

const FLAT_GROUND = preload("res://obstacles/flat_ground.tscn")
const BASIC_RAIL = preload("res://obstacles/basic_rail.tscn")
const BASIC_GAP = preload("res://obstacles/basic_gap.tscn")

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	pass

func spawn_new_obstacle() -> void:
	var last_obstacle: Obstacle = get_tree().get_nodes_in_group("obstacles").back()
	var chosen: int = randi_range(0, 10)
	print(chosen)
	var obstacle: Obstacle
	if chosen < 5:
		obstacle = BASIC_GAP.instantiate()
	elif chosen < 7:
		obstacle = FLAT_GROUND.instantiate()
	else:
		obstacle = BASIC_RAIL.instantiate()
	level.obstacles_container.add_child(obstacle)
	obstacle.global_position = Vector2(last_obstacle.edge.global_position.x, level.obstacle_spawn.global_position.y)

func spawn_starting_obstacles():
	var flat_ground: Obstacle = FLAT_GROUND.instantiate()
	level.obstacles_container.add_child(flat_ground)
	flat_ground.global_position = Vector2(0, level.obstacle_spawn.global_position.y)
	for _i in range(0, 10):
		spawn_new_obstacle()
	
