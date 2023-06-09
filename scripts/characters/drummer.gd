extends "res://scripts/character_controller.gd"

@onready var scanner := $Sprite/Scanner
@onready var tilemap := %TileMap
@onready var particles := $Sprite/ParticleSystem

func _process(_delta):
	if !active:
		return
	
	if Input.is_action_just_pressed("spell_puzzle"):
		var area_position = Vector2(position.x + scanner.position.x, position.y + scanner.position.y)
		var clicked_cell = tilemap.local_to_map(area_position)
		await break_block(clicked_cell)
			
func break_block(cell: Vector2):
	var tiledata = tilemap.get_cell_tile_data(0, cell)
	if tiledata and tiledata.get_custom_data("breakable"):
		particles.emitting = true
		tilemap.erase_cell(0, cell)
		await get_tree().create_timer(0.25).timeout
		particles.emitting = false
		for neighbor in tilemap.get_surrounding_cells(cell):
			break_block(neighbor)
