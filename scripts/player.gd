extends CharacterBody2D

# Get gravity from project settings
var GRAVITY = ProjectSettings.get_setting("physics/2d/default_gravity")

# Ready nodes
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

# Create variables
@export_group("movement")
@export var RUN_SPEED_DAMPING = 0.5
@export var SPEED = 200
@export var JUMP_VELOCITY = -350
@export_group("")

func _physics_process(delta: float) -> void:
	# handle gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	# handle jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	# reduce jump height for short presses of jump
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y *= 0.5
	
	# handle running
	var direction = Input.get_axis("left","right")
	if direction:
		velocity.x = lerpf(velocity.x, SPEED * direction, RUN_SPEED_DAMPING * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * delta)
	
	animated_sprite_2d.trigger_animation(velocity, direction)
	
	move_and_slide()
