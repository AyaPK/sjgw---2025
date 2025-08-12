extends Node

const SCORE_GAIN: float = 0.1

var skater: Skater
var ui: CanvasLayer
var score: float
var score_mult: int
var base_score_mult: int

var high_scores: HighScores

func _ready() -> void:
	high_scores = HighScores.load_or_create()

func _physics_process(_delta: float) -> void:
	if skater and ui:
		if !skater.dead:
			score += SCORE_GAIN
			if skater.grinding:
				score += 1
			ui.score.text = "Score: "+str(int(floor(score)))
	pass

func add_score(amount: int, description: String) -> void:
	score += (amount * score_mult)

func add_high_score(name: String, score: int) -> void:
	var scores_array = []
	
	for key in high_scores.high_scores.keys():
		var entry = high_scores.high_scores[key]
		scores_array.append({"name": entry[0], "score": entry[1]})
	
	scores_array.append({"name": name, "score": score})
	scores_array.sort_custom(func(a, b): return b["score"] < a["score"])
	scores_array = scores_array.slice(0, 10)
	
	for i in range(scores_array.size()):
		high_scores.high_scores["Slot%d" % (i + 1)] = [scores_array[i]["name"], scores_array[i]["score"]]
	


func is_high_score(score_to_check: int) -> bool:
	var scores_array = []
	
	for key in high_scores.high_scores.keys():
		var entry = high_scores.high_scores[key]
		scores_array.append(entry[1])
	
	if scores_array.size() < 10:
		return true
	var lowest_score = scores_array.min()
	
	return score_to_check > lowest_score
