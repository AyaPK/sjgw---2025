class_name HighScores extends Resource

@export var high_scores: Dictionary = {
	"Slot1": ["---", 0],
	"Slot2": ["---", 0],
	"Slot3": ["---", 0],
	"Slot4": ["---", 0],
	"Slot5": ["---", 0],
	"Slot6": ["---", 0],
	"Slot7": ["---", 0],
	"Slot8": ["---", 0],
	"Slot9": ["---", 0],
	"Slot10": ["---", 0],
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
