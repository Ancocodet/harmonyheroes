class_name Checkpoint extends Area2D

@export var id = 1

func _on_body_entered(_body):
	GameManager.checkpoint_reached(self)

func get_id():
	return id
