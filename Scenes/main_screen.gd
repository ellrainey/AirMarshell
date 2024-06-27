extends Node2D

var rng = RandomNumberGenerator.new()
var playerPlaneReady = false
var planeReady = [false, false, false, false, false]
var score = 0
var gameOver = false
var time = 0
var gameOverTime = 0
var warningTime = 0

func _ready():
	pass

#Function called when a plane is correctly directed by the player
func planeDirected(lane, correct):
	var plane = str("Plane", lane)
	var planeFrame = str(plane, "/planeSprite")
	var directionPath = str("Direction", lane, "/directions")
	if correct:
		get_node(planeFrame).play("success")
	else:
		get_node(planeFrame).play("misdirect")
	get_node(planeFrame).exists = false
	get_node(planeFrame).time = 0
	planeReady[lane - 1] = false
	get_node(directionPath).set_frame_and_progress(0, 0)

func _process(delta):
	#tick down warning timer if player is currently under warning
	if warningTime > 0:
		warningTime -= 1 * delta
	if warningTime <= 0:
		$Player/Warning.visible = false

	#planes are not ready by default
	for i in range(5):
		planeReady[i] = false

	#determine if and when a plane spawns
	time += delta
	if time >= 0.4:
		var planeSpawn = rng.randi_range(0, 2)
		time = 0
		if planeSpawn != 1:
			var locationSpawn = rng.randi_range(1,5)
			var directionSpawn = rng.randi_range(1,4)
			for i in range(5):
				if locationSpawn == i + 1:
					var planePathLoc = str("Plane", i+1, "/planeSprite")
					var planePathPos = str("Plane", i+1)
					var dirPathLoc = str("Direction", i+1, "/directions")
					if get_node(planePathLoc).exists == false:
						if directionSpawn < 3:
							get_node(dirPathLoc).set_frame_and_progress(directionSpawn, 0)
						else:
							get_node(dirPathLoc).set_frame_and_progress(directionSpawn + 1, 0)
						get_node(planePathPos).position.x = 120 + (228 * i)
						get_node(planePathPos).position.y = 66
						get_node(planePathLoc).exists = true
						get_node(planePathLoc).set_frame_and_progress(0, 0)

	#if plane is in correct range of frames, plane is ready
	for i in range(5):
		var planePathReady = str("Plane", i+1, "/planeSprite")
		if 2 <= get_node(planePathReady).frame and get_node(planePathReady).frame <= 6 and gameOver == false:
			planeReady[i] = true#something about pplaneready is messing stuff up

	#game over
	for i in range(5):
		var planePathGameOver = str("Plane", i+1, "/planeSprite")
		if get_node(planePathGameOver).frame == 7 and gameOver == false:
			Vars.finalScore = score
			get_node(planePathGameOver).play("lose")
			print(get_node(planePathGameOver).animation)
			gameOver = true
	if gameOver == true:
		gameOverTime += 1
	if gameOverTime == 10:
		get_tree().change_scene_to_file.bind("res://Scenes/Game_Over.tscn").call_deferred()

	#planes being directed
	var newDirectionPath = str("Direction", $Player.playerLane, "/directions" )
	if planeReady[$Player.playerLane - 1] == true:
		if $Player.stickDir == get_node(newDirectionPath).frame:
			planeDirected($Player.playerLane, true)
			score += 1
		elif $Player.stickDir != 0 and $Player/Warning.visible == false:
			planeDirected($Player.playerLane, false)
			$Player/Warning.visible = true
			warningTime = 5
		elif $Player.stickDir != 0 and $Player/Warning.visible == true: #and gameOver == false:
			Vars.finalScore = score
			gameOver = true

	#score display
	$scoreLabel.text = str(score)
