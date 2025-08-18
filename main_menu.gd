extends Node2D

@onready var high_scores: HBoxContainer = $HighScores
@onready var high_score_container: VBoxContainer = $HighScores/HighScoreContainer
@onready var high_score_container_2: VBoxContainer = $HighScores/HighScoreContainer2

const HIGH_SCORE_LABEL = preload("res://nodes/high_score_label.tscn")

func _ready() -> void:
	$VBoxContainer/Start.grab_focus()
	show_high_scores()

func _process(_delta: float) -> void:
	pass

func show_high_scores() -> void:
	for child in high_score_container.get_children():
		child.queue_free()
		await child.tree_exited
	for child in high_score_container_2.get_children():
		child.queue_free()
		await child.tree_exited
	for x in range(1, 6):
		high_score_container.add_child(_load_score_to_slot(str(x)))
	for x in range(6, 11):
		high_score_container_2.add_child(_load_score_to_slot(str(x)))
	high_scores.show()

func _load_score_to_slot(slot: String) -> Label:
	var label: Label = HIGH_SCORE_LABEL.instantiate()
	@warning_ignore("shadowed_variable")
	var score: Array = ScoreManager.high_scores.high_scores["Slot"+slot]
	var spacer: String
	if slot == "10":
		spacer = " "
	else:
		spacer = "  "
	label.text = slot+"."+spacer+score[0]+" - "+str(score[1])
	return label


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://skatepark.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_credits_pressed() -> void:
	$VBoxContainer.hide()
	$HighScores.hide()
	$Credits.show()
	$backbutton.show()
	$backbutton.grab_focus()


func _on_backbutton_pressed() -> void:
	$Credits.hide()
	$backbutton.hide()
	$VBoxContainer.show()
	$HighScores.show()
	$VBoxContainer/Credits.grab_focus()
