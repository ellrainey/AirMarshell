extends Node2D

var pos = 1
var first = 450
var dist = 108

func _ready():
	#game over screen score and difficulty display
	#FIX: I will eventually make the game over screen display the difficulty of the last run
	#var diff
	#match Vars.difficulty:
		#1:
			#diff = "easy"
		#3:
			#diff = "medium"
		#5:
			#diff = "hard"
	#$diffLabel.text = diff
	$scoreLabel.text = str(Vars.finalScore)

func _process(_delta):
	#selection and selector movement
	if Input.is_action_just_pressed("ui_down") or Input.is_action_just_pressed("ui_up"):
		match pos:
			1:
				pos = 2
			2:
				pos = 1
	if Input.is_action_just_pressed("ui_accept"):
		match pos:
			1:
				get_tree().change_scene_to_file.bind("res://Scenes/main_screen.tscn").call_deferred()
			2:
				get_tree().change_scene_to_file.bind("res://Scenes/main_menu.tscn").call_deferred()
	$menuSelect.position.y = first + ((pos - 1) * dist)
