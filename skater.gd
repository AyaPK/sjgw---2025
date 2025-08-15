class_name Skater extends CharacterBody2D

@export var jump_force: float = 300.0
@export var gravity: float = 1000.0
@export var max_fall_speed: float = 1000.0
@onready var animated_sprite: AnimationPlayer = $AnimationPlayer
@onready var landing_sfx: AudioStreamPlayer = $LandSFX 
@onready var skate_particles: GPUParticles2D = $skate_particles
@onready var death_particles: GPUParticles2D = $death_particles
@onready var sprite: Sprite2D = $Sprite2D
@onready var dead_sfx: AudioStreamPlayer = $DeadSFX

const SHADOW = preload("res://nodes/shadow.tscn")

var tricking: bool = false
var trick_selected: bool = false
var grinding: bool = false
var was_on_floor: bool = false
var dead: bool = false

func _ready() -> void:
	ScoreManager.skater = self

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		velocity.y = min(velocity.y, max_fall_speed)
		skate_particles.emitting = false
	else:
		if !grinding:
			skate_particles.process_material.color = "858585"
		elif grinding:
			skate_particles.process_material.color = "f9be00"
		skate_particles.emitting = true
		if Input.is_action_just_pressed("a"):
			$OllieSFX.play()
			velocity.y = -jump_force
	if Input.is_action_just_pressed("b"):
		tricking = true
	
	if global_position.x < 100:
		velocity.x = 10
	else:
		velocity.x = 0
	if !dead:
		move_and_slide()
	update_animation()
	
	if !was_on_floor and is_on_floor():
		landing_sfx.play()
	was_on_floor = is_on_floor()

func update_animation():
	if tricking:
		if !trick_selected:
			if Input.is_action_pressed("move_left"):
				animated_sprite.play("shuvit")
				trick_selected = true
			elif Input.is_action_pressed("move_down"):
				animated_sprite.play("varial flip")
				trick_selected = true
			elif Input.is_action_pressed("move_up"):
				animated_sprite.play("heelflip")
				trick_selected = true
			elif Input.is_action_pressed("move_right"):
				animated_sprite.play("hardflip")
				trick_selected = true
			else:
				animated_sprite.play("kickflip")
				trick_selected = true
		if !is_on_floor():
			return
		else:
			tricking = false
			trick_selected = false
	
	if not is_on_floor():
		$RollSFX.stop()
		if velocity.y < 0:
			$GrindSFX.stop()
			animated_sprite.play("jump")
		else:
			animated_sprite.play("fall")
	elif grinding:
		animated_sprite.play("grind")
		$RollSFX.stop()
		if !$GrindSFX.playing and !dead:
			$GrindSFX.play()
	else:
		animated_sprite.play("idle")
		$GrindSFX.stop()
		if !$RollSFX.playing and !dead:
			$RollSFX.play()

func _stop_tricking() -> void:
	tricking = false
	trick_selected = false
	ScoreManager.add_score(25, animated_sprite.current_animation)

func play_trick_sfx() -> void:
	pass

func mute_audio() -> void:
	$RollSFX.stop()
	$GrindSFX.stop()

func should_spawn_shadow() -> void:
	if ObstacleManager.boosting:
		spawn_shadow()

func spawn_shadow() -> void:
	var shadow: Shadow = SHADOW.instantiate()
	get_parent().add_child(shadow)
	get_parent().move_child(shadow, 2)
	shadow.global_position = global_position
	shadow.global_position.y -= 14
	shadow.frame = sprite.frame

func _on_shadow_timer_timeout() -> void:
	if ObstacleManager.boosting and !dead:
		spawn_shadow()
 
