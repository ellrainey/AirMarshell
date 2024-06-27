extends Node2D

var playerLane = 3
var rolling = false
var weight = 0
var stickDir = 0
var startPos = 120
var distBetween = 228

func _ready():
	$turtleSprite.speed_scale = 2.25

func _process(_delta):
	#player movement with rolling animation
	print(startPos + ((playerLane - 1) * distBetween))
	stickDir = 0
	if rolling:
		if position.x == startPos + ((playerLane - 1) * distBetween):
			#if not (Input.is_action_pressed("left") or Input.is_action_pressed("right")):
			print("1")
			rolling = false
			$turtleSprite.play("midmid")
			weight = 0
			#else:
				#playerLane += weight
				#print("2")
				#
				#match weight:
					#1:
						#$turtleSprite.play("rollRight")
					#-1:
						#$turtleSprite.play("rollLeft")
					#1:
						#playerLane += 1
						#rolling = true
						#weight = 1
						#$turtleSprite.play("rollRight")
						#stickDir = 0
					#-1:
						#playerLane -= 1
						#rolling = true
						#weight = -1
						#$turtleSprite.play("rollLeft")
						#stickDir = 0
						
		else:
			position.x = (120 + ((playerLane - 1 - weight) * 228)) + (weight * 57 * $turtleSprite.frame)
	else:
		if Input.is_action_pressed("left") and playerLane > 1:
			playerLane -= 1
			rolling = true
			weight = -1
			$turtleSprite.play("rollLeft")
			stickDir = 0
		elif Input.is_action_pressed("right") and playerLane < 5:
			playerLane += 1
			rolling = true
			weight = 1
			$turtleSprite.play("rollRight")
			stickDir = 0
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
	
