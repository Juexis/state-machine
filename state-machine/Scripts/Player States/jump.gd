extends PlayerState

@export
var fall_state: PlayerState

@export var jump_vel = -250
@export var acceleration = 400
@export var friction = 200

func enter():
	super()
	parent.velocity.y += jump_vel

func process_physics(delta):
	var input_axis = Input.get_axis("move_left", "move_right")
	parent.velocity.x = move_toward(parent.velocity.x, speed * input_axis, acceleration * delta)
	
	if parent.velocity.y > 0:
		return fall_state
