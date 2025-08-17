class_name ScoreAdded extends Node2D

@onready var score: RichTextLabel = $Score
@onready var animation: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	pass 

func _process(delta: float) -> void:
	pass

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	print("aaaa")
	remove_from_group("score_popups_showing")
	add_to_group("score_popups_hidden")
