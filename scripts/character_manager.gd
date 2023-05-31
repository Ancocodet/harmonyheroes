extends Node

var characters
@export var current_character = 0

func _ready():
	characters = get_children()
	characters[current_character].activate()
	GameManager.teleport_player.connect(_on_teleport)

func _process(_delta):
	if Input.is_action_just_pressed("char_one") and current_character != 0:
		switch_to(0)
		return
	if Input.is_action_just_pressed("char_two") and current_character != 1:
		switch_to(1)
		return
	if Input.is_action_just_pressed("char_three") and current_character != 2:
		switch_to(2)
		return

func switch_to(index):
	if current_character == index:
		return
	
	characters[current_character].deactivate()
	current_character = index
	characters[current_character].activate()
	
	$"../CanvasLayer/UI".selected_character(index)

func _on_teleport():
	var position = characters[current_character].position
	for character in characters:
		if character != characters[current_character]:
			character.teleport(position.x, position.y)
