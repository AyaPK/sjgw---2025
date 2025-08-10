class_name Level extends Node2D

@onready var obstacles_container: Node2D = $ObstaclesContainer
@onready var obstacle_spawn: Marker2D = $Marker2D
@onready var skater: Skater = $Skater
@onready var bg: Node2D = $TileMapLayer2
@onready var level_ui: LevelUI = $LevelUi
@onready var bg_audio: AudioStreamPlayer = $AudioStreamPlayer

const MAIN_SONG = preload("res://assets/main_song.mp3")
const MAIN_SONG_KICK_ONLY = preload("res://assets/main_song_kick_only.mp3")

func _ready() -> void:
	ObstacleManager.level = self
	ObstacleManager.spawn_starting_obstacles()
	ScoreManager.ui.show()
	ScoreManager.score = 0

func _process(_delta: float) -> void:
	pass

func _on_deathplane_body_entered(body: Skater) -> void:
	if body in get_tree().get_nodes_in_group("skater"):
		body.sprite.hide()
		body.dead = true
		body.death_particles.emitting = true
		body.dead_sfx.play()
		ScoreManager.ui.death_buttons.show()
		ScoreManager.ui.retry.grab_focus()
		ObstacleManager.pause_movement()
		bg_audio.stream = MAIN_SONG_KICK_ONLY
		bg_audio.play()
		body.mute_audio()
