class_name HighScores extends Resource

@export var high_scores: Dictionary = {
	"Slot1": ["SOF", 1000],
	"Slot2": ["TJA", 900],
	"Slot3": ["M G", 800],
	"Slot4": ["AME", 700],
	"Slot5": ["WIR", 600],
	"Slot6": ["E25 ", 500],
	"Slot7": ["POG", 400],
	"Slot8": ["BY ", 300],
	"Slot9": ["AYA", 200],
	"Slot10": ["OOF", 100],
}

const SAVE_PATH: String = "user://high_scores.tres"

func save() -> void:
	ResourceSaver.save(self, SAVE_PATH)

static func load_or_create() -> HighScores:
	var res: HighScores
	if FileAccess.file_exists(SAVE_PATH):
		res = load(SAVE_PATH) as HighScores
	else:
		res = HighScores.new()
	return res
