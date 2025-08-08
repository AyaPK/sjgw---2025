class_name Skater extends CharacterBody2D

@export var jump_force: float = 300.0
@export var gravity: float = 1000.0
@export var max_fall_speed: float = 1000.0
@onready var animated_sprite: AnimationPlayer = $AnimationPlayer

var grinding: bool = false

func _physics_process(delta):
	velocity.x = 0

	if not is_on_floor():
		velocity.y += gravity * delta
		velocity.y = min(velocity.y, max_fall_speed)
	else:
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = -jump_force

	move_and_slide()

	update_animation()

func update_animation():
	if not is_on_floor():
		if velocity.y < 0:
			animated_sprite.play("jump")
		else:
			animated_sprite.play("fall")
	elif grinding:
		animated_sprite.play("grind")
	else:
		animated_sprite.play("idle")
	
