extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	pass

func _spawn_new_flatground() -> void:
	if needs_new_obstacle():
		var i: int = randi_range(0, 10)
		if i > 3:
			get_tree().current_scene.add_flat_ground()
		else:
			get_tree().current_scene.add_basic_rail()

func needs_new_obstacle():
	return len(get_tree().get_nodes_in_group("obstacles")) < 5
