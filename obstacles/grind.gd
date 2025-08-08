class_name Grind extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Skater) -> void:
	if body in get_tree().get_nodes_in_group("skater"):
		body.grinding = true


func _on_body_exited(body: Skater) -> void:
	if body in get_tree().get_nodes_in_group("skater"):
		body.grinding = false
