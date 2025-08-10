class_name Shadow extends Sprite2D

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	global_position.x -= ObstacleManager.move_speed

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
