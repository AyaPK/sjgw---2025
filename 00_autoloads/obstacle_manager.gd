extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _spawn_new_flatground() -> void:
	if get_tree().current_scene.needs_new_obstacle():
		get_tree().current_scene.add_flat_ground()
