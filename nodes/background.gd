extends Node2D

@onready var bg_one: TileMapLayer = $bg_one
@onready var bg_two: TileMapLayer = $bg_two
@onready var edge_one: VisibleOnScreenNotifier2D = $bg_one/edge_one
@onready var edge_two: VisibleOnScreenNotifier2D = $bg_two/edge_two

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	bg_one.global_position.x -= 0.5
	bg_two.global_position.x -= 0.5

func _on_edge_one_screen_exited() -> void:
	bg_one.global_position.x = edge_two.global_position.x + 32

func _on_edge_two_screen_exited() -> void:
	bg_two.global_position.x = edge_one.global_position.x + 32
