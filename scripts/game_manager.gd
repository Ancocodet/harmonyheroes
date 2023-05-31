extends Node

var current_checkpoint = null
signal teleport_player()

func checkpoint_reached(checkpoint):
	if current_checkpoint == null:
		current_checkpoint = checkpoint
	elif checkpoint.id <= current_checkpoint.id:
		return

	current_checkpoint = checkpoint
	teleport_player.emit()
	DataManager.save_game(get_tree().current_scene.get_name(), 1)
