class_name Skater extends CharacterBody2D

@export var jump_force: float = 300.0
@export var gravity: float = 1000.0
@export var max_fall_speed: float = 1000.0
@onready var animated_sprite: AnimationPlayer = $AnimationPlayer
@onready var landing_sfx: AudioStreamPlayer = $LandSFX 

var tricking: bool = false
var grinding: bool = false
var was_on_floor: bool = false

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		velocity.y = min(velocity.y, max_fall_speed)
	else:
		if Input.is_action_just_pressed("a"):
			$OllieSFX.play()
			velocity.y = -jump_force

	if Input.is_action_just_pressed("b"):
		tricking = true
	
	if global_position.x < 75:
		velocity.x = 10
	else:
		velocity.x = 0
	move_and_slide()
	update_animation()
	
	if !was_on_floor and is_on_floor():
		landing_sfx.play()

	was_on_floor = is_on_floor()

func update_animation():
	if tricking:
		animated_sprite.play("kickflip")
		if !is_on_floor():
			return
		else:
			tricking = false
	
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
		if !$GrindSFX.playing:
			$GrindSFX.play()
	else:
		animated_sprite.play("idle")
		$GrindSFX.stop()
		if !$RollSFX.playing:
			$RollSFX.play()

func _stop_tricking() -> void:
	tricking = false
