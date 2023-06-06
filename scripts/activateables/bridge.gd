extends "res://scripts/activatable.gd"

@export var tiles: Array = [Vector2.ZERO]

@export var start_tile: Vector2
@export var end_tile: Vector2

@export var bridge_tile: Vector2 = Vector2(1, 5)
@onready var tile_map = $TileMap

func activate():
	for i in range(end_tile.x - start_tile.x):
		var tile = Vector2(start_tile.x + i, start_tile.y)
		tile_map.set_cell(0, tile, 0, bridge_tile)
		await get_tree().create_timer(0.15).timeout
	await get_tree().create_timer(0.15 * tiles.size()).timeout
	
func deactivate():
	await get_tree().create_timer(5).timeout
	for i in range(end_tile.x - start_tile.x):
		var tile = Vector2(start_tile.x + i, start_tile.y)
		tile_map.erase_cell(0, tile)
		await get_tree().create_timer(0.25).timeout
	tile_map.set_cell(0, connected_tile, 0, Vector2(3, 0), 1)
