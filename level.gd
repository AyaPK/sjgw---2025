class_name Level extends Node2D

@onready var obstacles_container: Node2D = $ObstaclesContainer
@onready var obstacle_spawn: Marker2D = $Marker2D

func _ready() -> void:
	ObstacleManager.level = self
	ObstacleManager.spawn_starting_obstacles()

func _process(delta: float) -> void:
	pass
