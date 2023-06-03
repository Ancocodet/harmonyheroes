extends "res://scripts/activatable.gd"

@export var tiles: Array = [Vector2.ZERO]
@export var bridge_tile: Vector2 = Vector2(1, 5)
@onready var tile_map = $"../../TileMap"

func activate():
	$Camera.enabled = true
	for tile in tiles:
		tile_map.set_cell(0, tile, 0, bridge_tile)
		await get_tree().create_timer(0.25).timeout
	await get_tree().create_timer(0.25 * tiles.size()).timeout
	$Camera.enabled = false
	
