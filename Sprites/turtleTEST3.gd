extends AnimatedSprite2D

var stickDir = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	#default stick position is set to 0
	stickDir = 0
	
	if Input.is_action_pressed("rightstick_left") and Input.is_action_pressed("rightstick_right"):
		if Input.is_action_pressed("leftstick_left") and Input.is_action_pressed("leftstick_right"):
			play("midmid")
		elif Input.is_action_pressed("leftstick_left"):
			play("leftmid")
		elif Input.is_action_pressed("leftstick_right"):
			play("rightmid")
		else:
			play("midmid")
	elif Input.is_action_pressed("rightstick_left"):
		if Input.is_action_pressed("leftstick_left") and Input.is_action_pressed("leftstick_right"):
			play("midleft")
		elif Input.is_action_pressed("leftstick_left"):
			play("leftleft")
			stickDir = 4
		elif Input.is_action_pressed("leftstick_right"):
			play("rightleft")
			stickDir = 5
		else:
			play("midleft")
	elif Input.is_action_pressed("rightstick_right"):
		if Input.is_action_pressed("leftstick_left") and Input.is_action_pressed("leftstick_right"):
			play("midright")
		elif Input.is_action_pressed("leftstick_left"):
			play("leftright")
			stickDir = 1
		elif Input.is_action_pressed("leftstick_right"):
			play("rightright")
			stickDir = 2
		else:
			play("midright")
	else:
		if Input.is_action_pressed("leftstick_left") and Input.is_action_pressed("leftstick_right"):
			play("midmid")
		elif Input.is_action_pressed("leftstick_left"):
			play("leftmid")
		elif Input.is_action_pressed("leftstick_right"):
			play("rightmid")
		else:
			play("midmid")
