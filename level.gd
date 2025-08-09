class_name Level extends Node2D

@onready var obstacles_container: Node2D = $ObstaclesContainer
@onready var obstacle_spawn: Marker2D = $Marker2D
@onready var skater: Skater = $Skater
@onready var bg: Node2D = $TileMapLayer2

const MAIN_SONG = preload("res://assets/main_song.mp3")
const MAIN_SONG_KICK_ONLY = preload("res://assets/main_song_kick_only.mp3")

func _ready() -> void:
	ObstacleManager.level = self
	ObstacleManager.spawn_starting_obstacles()

func _process(_delta: float) -> void:
	pass


func _on_deathplane_body_entered(body: Skater) -> void:
	if body in get_tree().get_nodes_in_group("skater"):
		body.sprite.hide()
		body.dead = true
		body.death_particles.emitting = true
		ObstacleManager.pause_movement()
