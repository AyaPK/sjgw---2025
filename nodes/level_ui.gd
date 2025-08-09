extends CanvasLayer

@onready var score: RichTextLabel = $Score

func _ready() -> void:
	ScoreManager.ui = self

func _process(_delta: float) -> void:
	pass
