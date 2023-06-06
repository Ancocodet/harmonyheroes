extends Control

var current_selection = 0
var character_icons
var character_icons_active = []

func _ready():
	character_icons = [%CharOne, %CharTwo, %CharThree]
	character_icons_active = [%CharOneActive, %CharTwoActive, %CharThreeActive]

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		pause()
		
func selected_character(index):
	character_icons_active[current_selection].visible = false
	character_icons[current_selection].visible = true
	
	character_icons[index].visible = false
	character_icons_active[index].visible = true
	
	current_selection = index

func pause():
	if $End.visible:
		return
		
	if $Pause.visible:
		if DisplayServer.mouse_get_mode() == DisplayServer.MOUSE_MODE_VISIBLE:
			DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_HIDDEN)
		$Pause.visible = false
		get_tree().paused = false
	else:
		if DisplayServer.mouse_get_mode() == DisplayServer.MOUSE_MODE_HIDDEN:
			DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_VISIBLE)
		$Pause.visible = true
		get_tree().paused = true

func game_ended():
	if !$End.visible:
		if DisplayServer.mouse_get_mode() == DisplayServer.MOUSE_MODE_HIDDEN:
			DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_VISIBLE)
		$End.visible = true
		get_tree().paused = true

func back_to_menu():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
	
func exit_game():
	get_tree().quit()
