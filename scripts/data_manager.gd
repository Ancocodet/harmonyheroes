extends Node

const FILE_NAME = "user://game-data.json"

var data = {
	"config": {
		"audio": {
			"master": 100.0,
			"music": 100.0,
			"effects": 100.0
		}
	},
	"save_game": {
		"scene": "level_1",
		"checkpoint": 0   
	}
}

func get_level_to_load():
	return "res://scenes/levels/" + data.save_game.scene + ".tscn"

func _ready():
	load_file()

func save_game(scene: String, checkpoint: int):
	data.save_game.scene = scene
	data.save_game.checkpoint = checkpoint
	save_file()

func save_file():
	var file = FileAccess.open(FILE_NAME, FileAccess.WRITE)
	file.store_string(JSON.stringify(data))
	file.close()

func load_file():
	if(FileAccess.file_exists(FILE_NAME)):
		var file = FileAccess.open(FILE_NAME, FileAccess.READ)
		var json = JSON.parse_string(file.get_as_text())
		file.close()
		if typeof(json) == TYPE_DICTIONARY:
			data = json
