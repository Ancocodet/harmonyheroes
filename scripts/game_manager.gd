extends Node

var current_checkpoint = null
var activated_books = []

signal teleport_player()
signal activated_book(tile: Vector2)

func checkpoint_reached(checkpoint):
	if current_checkpoint == null:
		current_checkpoint = checkpoint
	elif checkpoint.id <= current_checkpoint.id:
		return

	current_checkpoint = checkpoint
	teleport_player.emit()
	DataManager.save_game(get_tree().current_scene.get_name(), 1)

func activate_book(tile: Vector2):
	if !activated_books.has(tile):
		activated_books.append(tile)
		activated_book.emit(tile)
