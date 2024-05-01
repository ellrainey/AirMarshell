extends AnimatedSprite2D

var time = 0
var intTime = 0
var exists = false

# Called when the node enters the scene tree for the first time.
func _ready():
	
	animation = "gone"
	set_frame_and_progress(0,0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	#make plane move in resolution with the game
	if exists:
		animation = "standard"
		if get_parent().get_parent().score <= 50:
			time += delta * ((get_parent().get_parent().score * 0.4 * Vars.difficulty) + 3.5)
		else:
			time += delta * ((50 * 0.85) + 3)
		intTime = int(time)
		position.y = 0 + intTime * 6
		set_frame_and_progress(time / 6, 0)
