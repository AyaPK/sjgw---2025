class_name Skater extends CharacterBody2D

@export var jump_force: float = 400.0
@export var gravity: float = 1000.0
@export var max_fall_speed: float = 1000.0
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta):
	# No horizontal movement
	velocity.x = 0

	# Gravity
	if not is_on_floor():
		velocity.y += gravity * delta
		velocity.y = min(velocity.y, max_fall_speed)
	else:
		# Jump on input
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = -jump_force

	# Move the player (mainly vertical movement)
	move_and_slide()

	# Update animations
	update_animation()

func update_animation():
	return
	if not is_on_floor():
		if velocity.y < 0:
			animated_sprite.play("jump")
		else:
			animated_sprite.play("fall")
	else:
		animated_sprite.play("run")
