extends PlayerState

@export
var idle_state: PlayerState

@export var acceleration = 400
@export var friction = 200

func process_physics(delta):
	var input_axis = Input.get_axis("move_left", "move_right")
	parent.velocity.x = move_toward(parent.velocity.x, speed * input_axis, acceleration * delta)
	
	if parent.is_on_floor():
		return idle_state
