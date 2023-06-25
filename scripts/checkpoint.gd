class_name Checkpoint extends Area2D

@export var id = 1
@export var checked_atlas = Vector2(3, 1) 
@onready var tilemap = $"../../TileMap"

var checked = false

func _on_body_entered(_body):
	if !checked:
		checked = true
		GameManager.checkpoint_reached(self)
		var area_position = Vector2(position.x, position.y)
		var clicked_cell = tilemap.local_to_map(area_position)
		tilemap.set_cell(0, clicked_cell, 0, checked_atlas)

func get_id():
	return id
