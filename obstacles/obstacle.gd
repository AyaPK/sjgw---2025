class_name Obstacle extends Node2D

@onready var edge: VisibleOnScreenNotifier2D = $Edge

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func _physics_process(_delta: float) -> void:
	global_position.x -= ObstacleManager.move_speed
	pass

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	ObstacleManager.spawn_new_obstacle()
	queue_free()
