extends CharacterBody2D

@export var speed = 10.0
@export var jump_force = 750.0
@export var gravity = 1200.0

var screen_size

func _ready():
	screen_size = get_viewport_rect().size

func _physics_process(delta):
	var camera = get_viewport_transform()
	
	if Input.is_action_pressed("move_right"):
		velocity.x += speed
	elif Input.is_action_pressed("move_left"):
		velocity.x -= speed
	else:
		velocity.x = 0
		
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y -= jump_force
	else:
		velocity.y += delta * gravity
		
	move_and_slide()
	
