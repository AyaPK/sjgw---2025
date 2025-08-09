extends Node

var skater: Skater
var ui: CanvasLayer
var score: float

func _ready() -> void:
	pass

func _physics_process(_delta: float) -> void:
	if skater and ui:
		if !skater.dead:
			score += 0.1
			if skater.grinding:
				score += 1
			ui.score.text = "Score: "+str(int(floor(score)))
	pass
