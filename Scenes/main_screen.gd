extends Node2D



#V2 GOALS BY END OF FIRST WEEK OF APRIL
#new scenes for main menu, tutorial, and settings (and victory?)
#easy medium and hard change the speed of planes and the amount of directions (easy just has left and right) (hard includes the landing)
#getting to 100 on easy gives you the victory message and the bronze shell
#getting to 100 on normal gives victory and the silver shell and unlocks hard mode
#getting to 100 on hard gives victory and the diamond shell
#
#game over had restart and main menu buttons (press space to select text necessary in main menu and possibly game over scrreen)
#score text in game and game over is with pixel art
#
#add new plane frams and turtle roll
#add sounds and music
#add animation for plane correctly directed 
#incorrectly directing plane gives warning that wears off, incorrectly directing a plane while warned results in game over (add to tutorial)
#difficulty settings have some signal in game to show what you're playing (shell/stick color)
#switch to signals for plane and stick stuff makes incorrect direction stuff easier
#refactor code in planeBaseTest7
#exit button in main menu
#make last red frame a green frame
#sucess animation
#lose animation
#
#
#make back button red in menus
#add exit button
#warning add timer
#for warning make it so it's only if it resets back to zero and then misinput then gameover

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
	var planeFrame = str(plane, "/PlaneBaseTEST7")
	var directionPath = str("Direction", lane, "/directions2")
	if correct:
		get_node(planeFrame).play("success")
	else:
		get_node(planeFrame).play("misdirect")
	get_node(planeFrame).exists = false
	get_node(planeFrame).time = 0
	planeReady[lane - 1] = false
	get_node(directionPath).set_frame_and_progress(0, 0)
	score += 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	print($Player/turtleTEST3.stickDir)
	#print(warningTime)
	#reset the game on spacebar button press
	#if Input.is_action_just_pressed("ui_accept"):
		#get_tree().reload_current_scene()
	
	if warningTime > 0:
		warningTime -= 1 * delta
	
	if warningTime <= 0:
		#print("IN HERE")
		$Player/Warning.visible = false
	
	#planes are not ready by default
	for i in range(5):
		planeReady[i] = false
	
	#if and when a plane spawns
	time += delta
	if time >= 1:
		var planeSpawn = rng.randi_range(0, 2)
		time = 0
		if planeSpawn != 1:
			var locationSpawn = rng.randi_range(1,5)
			var directionSpawn = rng.randi_range(1,4)
			for i in range(5):
				if locationSpawn == i + 1:
					var planePathLoc = str("Plane", i+1, "/PlaneBaseTEST7")
					var planePathPos = str("Plane", i+1)
					var dirPathLoc = str("Direction", i+1, "/directions2")
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
		var planePathReady = str("Plane", i+1, "/PlaneBaseTEST7")
		if 2 <= get_node(planePathReady).frame and get_node(planePathReady).frame <= 6 and gameOver == false:
			planeReady[i] = true#something about pplaneready is messing stuff up
	
	if gameOver == true:
		gameOverTime += 1
	if gameOverTime == 10:
		get_tree().change_scene_to_file.bind("res://Scenes/Game_Over.tscn").call_deferred()
		
	#game over
	for i in range(5):
		var planePathGameOver = str("Plane", i+1, "/PlaneBaseTEST7")
		if get_node(planePathGameOver).frame == 7 and gameOver == false:
			Vars.finalScore = score
			get_node(planePathGameOver).play("lose")
			print(get_node(planePathGameOver).animation)
			#get_node(planePathGameOver).set_frame_and_progress(0,0)
			gameOver = true
			
		
	
	#planes being directed
	var newDirectionPath = str("Direction", $Player.playerLane, "/directions2" )
	if planeReady[$Player.playerLane - 1] == true:
		if $Player/turtleTEST3.stickDir == get_node(newDirectionPath).frame:
			planeDirected($Player.playerLane, true)
		elif $Player/turtleTEST3.stickDir != 0 and $Player/Warning.visible == false:
			planeDirected($Player.playerLane, false)
			$Player/Warning.visible = true
			warningTime = 5
		elif $Player/turtleTEST3.stickDir != 0 and $Player/Warning.visible == true: #and gameOver == false:
			Vars.finalScore = score
			#get_node(planePathGameOver).play("lose")
			#print(get_node(planePathGameOver).animation)
			#get_node(planePathGameOver).set_frame_and_progress(0,0)
			gameOver = true

	#score display
	$Label.text = str(score)
