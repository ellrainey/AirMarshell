extends Node2D

var pos = 1
var first = 450
var dist = 108

func _ready():
	#game over screen score and difficulty display
	var diff
	match Vars.difficulty:
		1:
			diff = "EASY"
		2:
			diff = "MEDIUM"
		3:
			diff = "HARD"
	$diffLabel.text = diff
	$scoreLabel.text = str(Vars.finalScore)
	
	#FIX: this code is horrendous, will change
	var highScore
	match Vars.difficulty:
		1:
			highScore = Vars.highScoreE
		2:
			highScore = Vars.highScoreM
		3:
			highScore = Vars.highScoreH
	if Vars.finalScore > highScore:
		highScore = Vars.finalScore
		$highScoreLabel.text = "NEW HIGH SCORE"
	else:
		$highScoreLabel.text = "HIGH SCORE: " + str(highScore)
	match Vars.difficulty:
		1:
			Vars.highScoreE = highScore
		2:
			Vars.highScoreM = highScore
		3:
			Vars.highScoreH = highScore
	SaveScript.save_game()

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
