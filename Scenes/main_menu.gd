extends Node2D

var pos = 1
var rows = 4
var dist = 108
var first = 264
var last = first + ((rows - 1) * dist)

func _ready():
	pass

func _process(delta):
	#selecion and selector movement
	if Input.is_action_just_pressed("ui_down"):
		match pos:
			rows:
				pos = 1
			_:
				pos += 1
	if Input.is_action_just_pressed("ui_up"):
		match pos:
			1:
				pos = rows
			_:
				pos -= 1
	if Input.is_action_just_pressed("ui_accept"):
		match pos:
			1:
				get_tree().change_scene_to_file.bind("res://Scenes/main_screen.tscn").call_deferred()
			3:
				get_tree().change_scene_to_file.bind("res://Scenes/difficulty_settings.tscn").call_deferred()
			4:
				get_tree().quit()

	$menuSelect.position.y = first + ((pos - 1) * dist)
