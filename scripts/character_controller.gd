extends CharacterBody2D

@export var max_speed = 900.0
@export var speed = 10.0
@export var jump_speed = -450.0
var health = 100.0

@onready var tile_map = %TileMap
@onready var character_manager = get_parent()
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var active = false

func activate():
	$Sprite/PointLight2D.enabled = true
	$Camera.enabled = true
	active = true
	
func deactivate():
	active = false
	$Sprite/PointLight2D.enabled = false
	$Camera.enabled = false

func teleport(x: float, y: float):
	position = Vector2(x, y)

func _physics_process(delta):
	if position.y > 750:
		if health > 0:
			health = 0
			character_manager.character_died()
		
	if health <= 0.0:
		velocity.x = 0
		return
	
	
	velocity.y += gravity * delta
	if !active:
		move_and_slide()
		return
	
	if Input.is_action_pressed("move_right"):
		velocity.x = min(velocity.x + speed, max_speed)
	elif Input.is_action_pressed("move_left"):
		velocity.x = max(velocity.x - speed, -max_speed)
	else:
		velocity.x = 0
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_speed
		
	var tile_below = get_tile_under_character()
	if tile_below and tile_below.get_custom_data("nature") and tile_below.get_custom_data("jump_force") * -1 > 0:
			velocity.y = tile_below.get_custom_data("jump_force")
		
	move_and_slide()
	
func get_tile_under_character():
	var below = Vector2(position.x, position.y + 32)
	var cell_below = tile_map.local_to_map(below)
	return tile_map.get_cell_tile_data(0, cell_below)
	
	
