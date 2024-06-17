#difficulty selection screen
extends Node2D

var pos = 1
var rows = 4
var dist = 138

func _ready():
	#highlight difficulty text on start
	match Vars.difficulty:
		1:
			$easySelect.frame = 1
		3:
			$mediumSelect.frame = 1
		5:
			$hardSelect.frame = 1

func _process(delta):
	#move the menu selector
	if Input.is_action_just_pressed("ui_down"):
		match pos:
			3:
				pos += 1
				$menuSelect.position.y = 600
			4:
				pos = 1
				$menuSelect.position.y = 126
			_:
				pos += 1
				$menuSelect.position.y += dist
	if Input.is_action_just_pressed("ui_up"):
		match pos:
			4:
				pos -= 1
				$menuSelect.position.y = 402
			1:
				pos = 4
				$menuSelect.position.y = 600
			_:
				pos -= 1
				$menuSelect.position.y -= dist

	#set difficulty
	if Input.is_action_just_pressed("ui_accept"):
		match pos:
			1:
				Vars.difficulty = 1
				$easySelect.frame = 1
				$mediumSelect.frame = 0
				$hardSelect.frame = 0
			2:
				Vars.difficulty = 3
				$easySelect.frame = 0
				$mediumSelect.frame = 1
				$hardSelect.frame = 0
			3:
				Vars.difficulty = 5
				$easySelect.frame = 0
				$mediumSelect.frame = 0
				$hardSelect.frame = 1
			4:
				get_tree().change_scene_to_file.bind("res://Scenes/main_menu.tscn").call_deferred()
