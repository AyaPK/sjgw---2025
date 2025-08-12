class_name LevelUI extends CanvasLayer

@onready var score: RichTextLabel = $Score
@onready var retry: Button = $DeathButtons/Retry
@onready var death_buttons: HBoxContainer = $DeathButtons
@onready var boost_sfx: AudioStreamPlayer = $BoostSFX
@onready var high_score_container: VBoxContainer = $HighScores/HighScoreContainer
@onready var high_score_container_2: VBoxContainer = $HighScores/HighScoreContainer2
@onready var high_scores: HBoxContainer = $HighScores

const HIGH_SCORE_LABEL = preload("res://nodes/high_score_label.tscn")

func _ready() -> void:
	ScoreManager.ui = self

func _process(_delta: float) -> void:
	pass

func _on_retry_pressed() -> void:
	get_tree().change_scene_to_file("res://playground.tscn")

func show_death_ui() -> void:
	ScoreManager.add_high_score("Aya", ScoreManager.score)
	ScoreManager.ui.death_buttons.show()
	ScoreManager.ui.retry.grab_focus()
	ScoreManager.ui.show_high_scores()
	ScoreManager.high_scores.save()

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
	var score: Array = ScoreManager.high_scores.high_scores["Slot"+slot]
	var spacer: String
	if slot == "10":
		spacer = " "
	else:
		spacer = "  "
	label.text = slot+"."+spacer+score[0]+" - "+str(score[1])
	return label
