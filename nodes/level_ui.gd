extends CanvasLayer

@onready var score: RichTextLabel = $Score
@onready var retry: Button = $DeathButtons/Retry
@onready var death_buttons: HBoxContainer = $DeathButtons

func _ready() -> void:
	ScoreManager.ui = self

func _process(_delta: float) -> void:
	pass

func _on_retry_pressed() -> void:
	get_tree().change_scene_to_file("res://playground.tscn")
