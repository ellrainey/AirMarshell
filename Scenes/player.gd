extends Node2D

var playerLane = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("left") and playerLane >= 2:
		playerLane -= 1
		position.x -= 228
	elif Input.is_action_just_pressed("right") and playerLane <= 4:
		playerLane += 1
		position.x += 228
	elif Input.is_action_just_pressed("right") and playerLane == 5:
		playerLane = 1
		position.x = 120
	elif Input.is_action_just_pressed("left") and playerLane == 1:
		playerLane = 5
		position.x = 1032
