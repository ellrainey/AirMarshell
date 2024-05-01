extends Node2D

var pos = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_down") and pos == 3:
		pos = 1
		$menuSelect.position.y = 325
	elif Input.is_action_just_pressed("ui_down"):
		pos += 1
		$menuSelect.position.y += 110
	elif Input.is_action_just_pressed("ui_up") and pos == 1:
		pos = 3
		$menuSelect.position.y = 545
	elif Input.is_action_just_pressed("ui_up"):
		pos -= 1
		$menuSelect.position.y -= 110
		
	if Input.is_action_just_pressed("ui_accept") and pos == 1:
		get_tree().change_scene_to_file.bind("res://main_screen.tscn").call_deferred()
	if Input.is_action_just_pressed("ui_accept") and pos == 3:
		get_tree().change_scene_to_file.bind("res://Scenes/difficulty_settings.tscn").call_deferred()
