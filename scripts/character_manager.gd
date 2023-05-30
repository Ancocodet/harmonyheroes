extends Node

var characters
@export var current_character = 0

func _ready():
	characters = [$Character1, $Character2, $Character3]
	characters[current_character].activate()

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
