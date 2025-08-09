extends Node

var level: Level

const FLAT_GROUND = preload("res://obstacles/flat_ground.tscn")
const BASIC_RAIL = preload("res://obstacles/basic_rail.tscn")
const BASIC_GAP = preload("res://obstacles/basic_gap.tscn")
const GAP_RAIL_UP = preload("res://obstacles/gap_rail_up.tscn")
const GAP_RAIL_DOWN = preload("res://obstacles/gap_rail_down.tscn")

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	pass

func spawn_new_obstacle() -> void:
	var last_obstacle: Obstacle = get_tree().get_nodes_in_group("obstacles").back()
	var chosen: int = randi_range(0, 10)
	var obstacle: Obstacle
	var height_change: int
	if chosen < 2:
		if level.obstacle_spawn.global_position.y >= 110:
			obstacle = GAP_RAIL_UP.instantiate()
			height_change = -36
		else:
			obstacle = GAP_RAIL_DOWN.instantiate()
			height_change = 36
		level.obstacles_container.add_child(obstacle)
	elif chosen < 4:
		obstacle = BASIC_GAP.instantiate()
		level.obstacles_container.add_child(obstacle)
		height_change = _calc_height_change()
		obstacle.gap_right.global_position.y += height_change
	elif chosen < 7:
		obstacle = FLAT_GROUND.instantiate()
		level.obstacles_container.add_child(obstacle)
	else:
		obstacle = BASIC_RAIL.instantiate()
		level.obstacles_container.add_child(obstacle)
	obstacle.global_position = Vector2(last_obstacle.edge.global_position.x, level.obstacle_spawn.global_position.y)
	if height_change:
		level.obstacle_spawn.global_position.y += height_change

func spawn_starting_obstacles():
	var flat_ground: Obstacle = FLAT_GROUND.instantiate()
	level.obstacles_container.add_child(flat_ground)
	flat_ground.global_position = Vector2(0, level.obstacle_spawn.global_position.y)
	for _i in range(0, 10):
		spawn_new_obstacle()
	
func _calc_height_change() -> int:
	var height_change = randi_range(-20, 20)
	if level.obstacle_spawn.global_position.y + height_change > 140:
		height_change = 140 - level.obstacle_spawn.global_position.y
	elif level.obstacle_spawn.global_position.y + height_change < 40:
		height_change = 40 + level.obstacle_spawn.global_position.y
	return height_change
