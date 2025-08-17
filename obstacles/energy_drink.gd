extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var appear: bool = randi_range(0, 20) <= 2
	if !appear or !ObstacleManager.spawn_energy_drinks:
		queue_free()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_pickup_spot_body_entered(_body: Node2D) -> void:
	ObstacleManager.short_boost()
	var boost_sfx: AudioStreamPlayer = ObstacleManager.level.level_ui.boost_sfx
	if !boost_sfx.playing:
		boost_sfx.play()
	else:
		boost_sfx.seek(0)
	queue_free()
