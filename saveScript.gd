class_name saveScript
extends Node

const SAVE_GAME_PATH := "user://savegame.save"

func save():
	var save_array = [Vars.highScoreE, Vars.highScoreM, Vars.highScoreH]
	return save_array

func save_game():
	var save_game = FileAccess.open(SAVE_GAME_PATH, FileAccess.WRITE)
	var json_string = JSON.stringify(save())
	save_game.store_line(json_string)

func load_game():
	if not FileAccess.file_exists(SAVE_GAME_PATH):
		return
		
		print(SAVE_GAME_PATH)
	var save_game = FileAccess.open(SAVE_GAME_PATH, FileAccess.READ)
	
	while save_game.get_position() < save_game.get_length():
		var json_string = save_game.get_line()
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		var node_data = json.get_data()
		Vars.highScoreE = node_data[0]
		Vars.highScoreM = node_data[1]
		Vars.highScoreH = node_data[2]
