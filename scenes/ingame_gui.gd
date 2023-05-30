extends Control

var current_selection = 0
var character_icons
var character_icons_active

func _ready():
	character_icons = [$CenterContainer/MarginContainer/CharacterSelection/CharOne, $CenterContainer/MarginContainer/CharacterSelection/CharTwo, $CenterContainer/MarginContainer/CharacterSelection/CharThree]
	character_icons_active = [$CenterContainer/MarginContainer/CharacterSelection/CharOneActive, $CenterContainer/MarginContainer/CharacterSelection/CharTwoActive, $CenterContainer/MarginContainer/CharacterSelection/CharThreeActive]

func selected_character(index):
	character_icons_active[current_selection].visible = false
	character_icons[current_selection].visible = true
	
	character_icons[index].visible = false
	character_icons_active[index].visible = true
	
	current_selection = index
