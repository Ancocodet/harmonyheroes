extends "res://scripts/character_controller.gd"

@export var cursor_targeting: Texture2D
@export var puzzle_range: float = 5

var current_cursor = Input.get_current_cursor_shape()
@onready var tile_map = $"../../TileMap"
@export var checked_atlas = Vector2(3, 1) 

func deactivate():
	active = false
	$Sprite/PointLight2D.enabled = false
	$Camera.enabled = false

	if DisplayServer.mouse_get_mode() == DisplayServer.MOUSE_MODE_VISIBLE:
		DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_HIDDEN)

func _process(_delta):
	if !active:
		return
	
	if get_global_mouse_position().distance_to(position) >= puzzle_range:
		if DisplayServer.mouse_get_mode() == DisplayServer.MOUSE_MODE_VISIBLE:
			DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_HIDDEN)
		return
	
	if DisplayServer.mouse_get_mode() == DisplayServer.MOUSE_MODE_HIDDEN:
		DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_VISIBLE)
		Input.set_custom_mouse_cursor(cursor_targeting)
		
	if Input.is_action_just_pressed("spell_puzzle"):
		var clicked_cell = tile_map.local_to_map(tile_map.get_local_mouse_position())
		var data = tile_map.get_cell_tile_data(0, clicked_cell)
		if data and data.get_custom_data("activateable"):
			$ParticleSystem.position = get_local_mouse_position()
			$ParticleSystem.emitting = true
			await get_tree().create_timer(0.5).timeout
			GameManager.activate_book(clicked_cell)
			tile_map.set_cell(0, clicked_cell, 0, checked_atlas)
			await get_tree().create_timer(0.25).timeout
			$ParticleSystem.emitting = false
