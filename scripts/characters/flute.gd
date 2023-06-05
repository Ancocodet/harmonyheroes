extends "res://scripts/character_controller.gd"

@onready var scanner := $Sprite/Scanner

func _process(_delta):
	if !active:
		return
	
	if Input.is_action_just_pressed("spell_puzzle"):
		var area_position = Vector2(position.x + scanner.position.x, position.y + scanner.position.y)
		var clicked_cell = tile_map.local_to_map(area_position)
		activate_block(clicked_cell)
			
func activate_block(cell: Vector2):
	var cords = tile_map.get_cell_atlas_coords(0, cell)
	var tiledata = tile_map.get_cell_tile_data(0, cell)
	if tiledata and tiledata.get_custom_data("nature"):
		if tile_map.get_cell_alternative_tile(0, cell) == 0:
			$Sprite/ParticleSystem.emitting = true
			tile_map.set_cell(0, cell, 0, Vector2(cords.x + 1, cords.y), 1)
			await get_tree().create_timer(0.25).timeout
			$Sprite/ParticleSystem.emitting = false
			for neighbor in tile_map.get_surrounding_cells(cell):
				activate_block(neighbor)
