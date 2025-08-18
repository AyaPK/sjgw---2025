extends Node

var level: Level

const FLAT_GROUND = preload("res://obstacles/flat_ground.tscn")
const BASIC_RAIL = preload("res://obstacles/basic_rail.tscn")
const BASIC_GAP = preload("res://obstacles/basic_gap.tscn")
const GAP_RAIL_UP = preload("res://obstacles/gap_rail_up.tscn")
const GAP_RAIL_DOWN = preload("res://obstacles/gap_rail_down.tscn")
const KICKER = preload("res://obstacles/kicker.tscn")
const BASE_MOVE_SPEED: int = 4
const BOOST_SPEED_ADDITION = 3

var objects_spawned: int = 0
var last_kicker: int = 0
var move_speed: float = BASE_MOVE_SPEED
var boosting: bool = false
var spawn_energy_drinks: bool = false

func _ready() -> void:
	if OS.get_name() == "Windows":
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func _physics_process(_delta: float) -> void:
	if boosting:
		move_speed = BASE_MOVE_SPEED + BOOST_SPEED_ADDITION
		ScoreManager.score += ScoreManager.SCORE_GAIN * 2
	else:
		move_speed = move_toward(move_speed, BASE_MOVE_SPEED, 0.05)
	pass

func spawn_new_obstacle(start: bool = false) -> void:
	var last_obstacle: Obstacle = get_tree().get_nodes_in_group("obstacles").back()
	var chosen: int = randi_range(0, 10)
	if start:
		chosen = 6
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
		var is_kicker: bool = randi_range(0, 10) < 6
		if is_kicker and objects_spawned - last_kicker > 3:
			obstacle = KICKER.instantiate()
			last_kicker = objects_spawned
		else:
			obstacle = FLAT_GROUND.instantiate()
		level.obstacles_container.add_child(obstacle)
	else:
		obstacle = BASIC_RAIL.instantiate()
		level.obstacles_container.add_child(obstacle)
	obstacle.global_position = Vector2(last_obstacle.edge.global_position.x, level.obstacle_spawn.global_position.y)
	if height_change:
		level.obstacle_spawn.global_position.y += height_change
	objects_spawned += 1

func spawn_starting_obstacles():
	spawn_energy_drinks = false
	var flat_ground: Obstacle = FLAT_GROUND.instantiate()
	level.obstacles_container.add_child(flat_ground)
	flat_ground.global_position = Vector2(0, level.obstacle_spawn.global_position.y)
	for _i in range(0, 10):
		spawn_new_obstacle(true)
	spawn_energy_drinks = true
	
func _calc_height_change() -> int:
	var height_change = randi_range(-20, 20)
	if level.obstacle_spawn.global_position.y + height_change > 140:
		height_change = 140 - level.obstacle_spawn.global_position.y
	elif level.obstacle_spawn.global_position.y + height_change < 40:
		height_change = 40 + level.obstacle_spawn.global_position.y
	return height_change

func pause_movement() -> void:
	level.obstacles_container.process_mode = Node.PROCESS_MODE_DISABLED
	level.bg.process_mode = Node.PROCESS_MODE_DISABLED

var boost_timer: SceneTreeTimer = null

func short_boost() -> void:
	if boost_timer:
		boost_timer.disconnect("timeout", Callable(self, "_end_boost"))
		boost_timer = null
	
	ScoreManager.score_mult = 4
	boosting = true
	boost_timer = get_tree().create_timer(2)
	boost_timer.connect("timeout", Callable(self, "_end_boost"))

func _end_boost() -> void:
	boosting = false
	boost_timer = null
	ScoreManager.score_mult = ScoreManager.base_score_mult
