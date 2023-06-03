extends Node

@export var connected_tile: Vector2

func _ready():
	GameManager.activated_book.connect(on_activation)
	
func on_activation(tile: Vector2):
	if connected_tile == tile:
		activate()

func activate():
	return
