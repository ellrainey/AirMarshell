extends Node2D

var pos = 1
var first = 534
var dist = 300
var page = 1

func _ready():
	pass

func _process(_delta):
	#selection and selector movement
	if Input.is_action_just_pressed("ui_right") or Input.is_action_just_pressed("ui_left"):
		match pos:
			1:
				pos = 2
			2:
				pos = 1
	if Input.is_action_just_pressed("ui_accept"):
		match pos:
			1:
				if page == 1:
					get_tree().change_scene_to_file.bind("res://Scenes/main_menu.tscn").call_deferred()
				else:
					var pageString = "tut" + str(page)
					get_node(pageString).visible = false
					page -= 1
			2:
				if page == 5:
					get_tree().change_scene_to_file.bind("res://Scenes/main_menu.tscn").call_deferred()
				else:
					page += 1
					var pageString = "tut" + str(page)
					get_node(pageString).visible = true
					
	$menuSelect.position.x = first + ((pos - 1) * dist)
