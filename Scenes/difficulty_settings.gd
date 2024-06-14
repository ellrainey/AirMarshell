extends Node2D

var pos = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_just_pressed("ui_down") and pos == 3:
		pos += 1
		$menuSelect.position.y = 600
	elif Input.is_action_just_pressed("ui_up") and pos == 4:
		pos -= 1
		$menuSelect.position.y = 398
	elif Input.is_action_just_pressed("ui_down") and pos == 4:
		pos = 1
		$menuSelect.position.y = 126
	elif Input.is_action_just_pressed("ui_down"):
		pos += 1
		$menuSelect.position.y += 136
	elif Input.is_action_just_pressed("ui_up") and pos == 1:
		pos = 4
		$menuSelect.position.y = 600
	elif Input.is_action_just_pressed("ui_up"):
		pos -= 1
		$menuSelect.position.y -= 136
		
	if Input.is_action_just_pressed("ui_accept") and pos == 1:
		Vars.difficulty = 1
	if Input.is_action_just_pressed("ui_accept") and pos == 2:
		Vars.difficulty = 3
	if Input.is_action_just_pressed("ui_accept") and pos == 3:
		Vars.difficulty = 5
	if Input.is_action_just_pressed("ui_accept") and pos == 4:
		get_tree().change_scene_to_file.bind("res://Scenes/main_menu.tscn").call_deferred()
		
	if Vars.difficulty == 1:
		$Label.text = "Current Difficulty: Easy"
		$Settings1/easySelect.frame = 1
		$Settings1/mediumSelect.frame = 0
		$Settings1/hardSelect.frame = 0
	elif Vars.difficulty == 3:
		$Label.text = "Current Difficulty: Medium"
		$Settings1/easySelect.frame = 0
		$Settings1/mediumSelect.frame = 1
		$Settings1/hardSelect.frame = 0
	elif Vars.difficulty == 5:
		$Label.text = "Current Difficulty: Hard"
		$Settings1/easySelect.frame = 0
		$Settings1/mediumSelect.frame = 0
		$Settings1/hardSelect.frame = 1
