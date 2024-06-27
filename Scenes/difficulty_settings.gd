#difficulty selection screen
#FIX: ugly, I'll fix this when I make all menus extend a common scene
extends Node2D

var pos = 1
var rows = 4
var dist = 138
var first = 126
var last = 600
var easy = 1
var medium = 2
var hard = 3

func _ready():
	#highlight difficulty text on start
	match Vars.difficulty:
		easy:
			$easySelect.frame = 1
		medium:
			$mediumSelect.frame = 1
		hard:
			$hardSelect.frame = 1

func _process(_delta):
	#selection and selector movement
	if Input.is_action_just_pressed("ui_down"):
		match pos:
			3:
				pos += 1
				$menuSelect.position.y = last
			rows:
				pos = 1
				$menuSelect.position.y = first
			_:
				pos += 1
				$menuSelect.position.y += dist
	if Input.is_action_just_pressed("ui_up"):
		match pos:
			rows:
				pos -= 1
				$menuSelect.position.y = 402
			1:
				pos = rows
				$menuSelect.position.y = last
			_:
				pos -= 1
				$menuSelect.position.y -= dist
	if Input.is_action_just_pressed("ui_accept"):
		match pos:
			1:
				Vars.difficulty = easy
				$easySelect.frame = 1
				$mediumSelect.frame = 0
				$hardSelect.frame = 0
			2:
				Vars.difficulty = medium
				$easySelect.frame = 0
				$mediumSelect.frame = 1
				$hardSelect.frame = 0
			3:
				Vars.difficulty = hard
				$easySelect.frame = 0
				$mediumSelect.frame = 0
				$hardSelect.frame = 1
			4:
				get_tree().change_scene_to_file.bind("res://Scenes/main_menu.tscn").call_deferred()
