extends State

@export var fall_state: State

var jump_vel: int = -250
var air_accel: int = 200
var air_fric: int = 200

func enter():
	super()
	parent.velocity.y += jump_vel

func process_physics(delta):
	var input_axis = Input.get_axis("move_left","move_right")
	
	if input_axis:
		parent.velocity.x = move_toward(parent.velocity.x, 120 * input_axis, air_accel * delta)
		parent.animations.flip_h = input_axis < 0
	else:
		parent.velocity.x = move_toward(parent.velocity.x, 0, air_fric * delta)
	
	if parent.velocity.y > 0:
		return fall_state
