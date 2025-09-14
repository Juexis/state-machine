extends State

@export var idle_state: State

var speed: int = 120
var acceleration: int = 800

func process_physics(delta):
	var input_axis: float = Input.get_axis("move_left","move_right")
	parent.velocity.x = move_toward(parent.velocity.x, speed * input_axis, acceleration * delta)
	
	# handle character flipping
	if input_axis < 0:
		parent.animations.flip_h = true
	elif input_axis > 0:
		parent.animations.flip_h = false
	
	
	if !input_axis:
		while (parent.velocity.x != 0):
			print(parent.velocity.x)
			parent.velocity.x = move_toward(parent.velocity.x, 0, 20 * delta)
		return idle_state
