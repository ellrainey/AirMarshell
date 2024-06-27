extends Node2D

var playerLane = 3
var rolling = false
var weight = 0
var stickDir = 0
var startPos = 120
var distBetween = 228

func _ready():
	$turtleSprite.speed_scale = 2

func _process(_delta):
	#player movement with rolling animation
	#FIX: some of this is redundant and needs to be moved to a function
	stickDir = 0
	if rolling:
		if position.x == startPos + ((playerLane - 1) * distBetween):
			if not (Input.is_action_pressed("left") or Input.is_action_pressed("right")):
				rolling = false
				$turtleSprite.play("midmid")
				weight = 0
			else:
				$turtleSprite.frame = 0
				if Input.is_action_pressed("left") and not Input.is_action_pressed("right") and playerLane > 1:
					playerLane -= 1
					weight = -1
					$turtleSprite.play("rollLeft")
					$turtleSprite.frame = 0
				elif Input.is_action_pressed("right") and not Input.is_action_pressed("left") and playerLane < 5:
					playerLane += 1
					weight = 1
					$turtleSprite.play("rollRight")
					$turtleSprite.frame = 0
		else:
			if $turtleSprite.animation == "rollLeft" or $turtleSprite.animation == "rollRight":
				position.x = (120 + ((playerLane - 1 - weight) * 228)) + (weight * 57 * $turtleSprite.frame)
	else:
		if Input.is_action_pressed("left") and not Input.is_action_pressed("right") and playerLane > 1:
			playerLane -= 1
			rolling = true
			weight = -1
			$turtleSprite.play("rollLeft")
			stickDir = 0
		elif Input.is_action_pressed("right") and not Input.is_action_pressed("left") and playerLane < 5:
			playerLane += 1
			rolling = true
			weight = 1
			$turtleSprite.play("rollRight")
			stickDir = 0
		#stick movement
		#FIX: ugly, need to clean this up
		elif Input.is_action_pressed("rightstick_left") and Input.is_action_pressed("rightstick_right"):
			if Input.is_action_pressed("leftstick_left") and Input.is_action_pressed("leftstick_right"):
				$turtleSprite.play("midmid")
			elif Input.is_action_pressed("leftstick_left"):
				$turtleSprite.play("leftmid")
			elif Input.is_action_pressed("leftstick_right"):
				$turtleSprite.play("rightmid")
			else:
				$turtleSprite.play("midmid")
		elif Input.is_action_pressed("rightstick_left"):
			if Input.is_action_pressed("leftstick_left") and Input.is_action_pressed("leftstick_right"):
				$turtleSprite.play("midleft")
			elif Input.is_action_pressed("leftstick_left"):
				$turtleSprite.play("leftleft")
				stickDir = 4
			elif Input.is_action_pressed("leftstick_right"):
				$turtleSprite.play("rightleft")
				stickDir = 5
			else:
				$turtleSprite.play("midleft")
		elif Input.is_action_pressed("rightstick_right"):
			if Input.is_action_pressed("leftstick_left") and Input.is_action_pressed("leftstick_right"):
				$turtleSprite.play("midright")
			elif Input.is_action_pressed("leftstick_left"):
				$turtleSprite.play("leftright")
				stickDir = 1
			elif Input.is_action_pressed("leftstick_right"):
				$turtleSprite.play("rightright")
				stickDir = 2
			else:
				$turtleSprite.play("midright")
		else:
			if Input.is_action_pressed("leftstick_left") and Input.is_action_pressed("leftstick_right"):
				$turtleSprite.play("midmid")
			elif Input.is_action_pressed("leftstick_left"):
				$turtleSprite.play("leftmid")
			elif Input.is_action_pressed("leftstick_right"):
				$turtleSprite.play("rightmid")
			else:
				$turtleSprite.play("midmid")
