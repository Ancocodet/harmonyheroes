extends "res://scripts/character_controller.gd"

@onready var scanner := $Sprite/Scanner
@onready var tilemap := %TileMap

func _process(_delta):
	if !active:
		return
	
	if Input.is_action_just_pressed("spell_puzzle"):
		var area_position = Vector2(position.x + scanner.position.x, position.y + scanner.position.y)
		var clicked_cell = tilemap.local_to_map(area_position)
		var tiledata = tilemap.get_cell_tile_data(0, clicked_cell)
		if tiledata and tiledata.get_custom_data("nature"):
			print_debug("Spell activated")
