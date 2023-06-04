extends Node

var characters
var dead_characters = []
@export var current_character = 0
@onready var spawnpoint = $"../SpawnPoint"

func _ready():
	if DisplayServer.mouse_get_mode() == DisplayServer.MOUSE_MODE_VISIBLE:
		DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_HIDDEN)
	
	characters = get_children()
	
	characters[0].position = Vector2(spawnpoint.position.x - 50, spawnpoint.position.y)
	characters[1].position = Vector2(spawnpoint.position.x, spawnpoint.position.y)
	characters[2].position = Vector2(spawnpoint.position.x + 50, spawnpoint.position.y)
	
	characters[current_character].activate()
	GameManager.teleport_player.connect(_on_teleport)

func respawn():
	dead_characters.clear()
	var last_checkpoint = GameManager.get_last_checkpoint()
	if last_checkpoint == null:
		characters[0].position = Vector2(spawnpoint.position.x - 50, spawnpoint.position.y)
		characters[1].position = Vector2(spawnpoint.position.x, spawnpoint.position.y)
		characters[2].position = Vector2(spawnpoint.position.x + 50, spawnpoint.position.y)
	else:
		for character in characters:
			character.position = last_checkpoint.position
	
	for character in characters:
		character.visible = true
		character.health = 100

func character_died():
	dead_characters.append(current_character)
	characters[current_character].visible = false
	if dead_characters.size() < 3:
		if characters[0].health > 0:
			switch_to(0)
		elif characters[1].health > 0:
			switch_to(1)
		if characters[2].health > 0:
			switch_to(2)
	else:
		respawn()

func _process(_delta):
	if Input.is_action_just_pressed("char_one") and current_character != 0:
		if characters[0].health > 0:
			switch_to(0)
		return
	if Input.is_action_just_pressed("char_two") and current_character != 1:
		if characters[1].health > 0:
			switch_to(1)
		return
	if Input.is_action_just_pressed("char_three") and current_character != 2:
		if characters[2].health > 0:
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
