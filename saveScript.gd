class_name saveScript
extends Node

const SAVE_GAME_PATH := "user://savegame.save"

func save():
	var save_dict = {
		"highScoreE" : Vars.highScoreE,
		"highScoreM" : Vars.highScoreM,
		"highScoreH" : Vars.highScoreH
	}
	return save_dict

func save_game():
	var save_game = FileAccess.open(SAVE_GAME_PATH, FileAccess.WRITE)
	var json_string = JSON.stringify(save())
	save_game.store_line(json_string)

func load_game():
	if not FileAccess.file_exists(SAVE_GAME_PATH):
		return
		
	var save_game = FileAccess.open(SAVE_GAME_PATH, FileAccess.READ)
	
	while save_game.get_position() < save_game.get_length():
		var json_string = save_game.get_line()
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		var node_data = json.get_data()
		
		print(node_data)
