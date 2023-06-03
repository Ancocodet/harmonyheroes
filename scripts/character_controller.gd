extends CharacterBody2D

@export var speed = 300.0
@export var jump_speed = -400.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var screen_size
var active = false

func _ready():
	screen_size = get_viewport_rect().size

func activate():
	$Sprite/Selector.visible = true
	$Sprite/PointLight2D.enabled = true
	$Camera.enabled = true
	active = true
	
func deactivate():
	active = false
	$Sprite/Selector.visible = false
	$Sprite/PointLight2D.enabled = false
	$Camera.enabled = false

func teleport(x: float, y: float):
	position = Vector2(x, y)

func _physics_process(delta):
	velocity.y += gravity * delta
	if !active:
		move_and_slide()
		return
	
	if Input.is_action_pressed("move_right"):
		velocity.x += speed
	elif Input.is_action_pressed("move_left"):
		velocity.x -= speed
	else:
		velocity.x = 0
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_speed
		
	move_and_slide()
	
