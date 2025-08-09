class_name GrindDown extends Grind


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_body_entered(body: Skater) -> void:
	if body in get_tree().get_nodes_in_group("skater"):
		body.rotation_degrees = 12
		body.grinding = true

func _on_body_exited(body: Skater) -> void:
	body.rotation = 0
	if body in get_tree().get_nodes_in_group("skater"):
		body.grinding = false
