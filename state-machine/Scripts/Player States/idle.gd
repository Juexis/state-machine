extends State

@export var run_state: State

@export var jump_state: State

@export var fall_state: State

func process_physics(delta):
	# set velocity back to zero
	parent.velocity.x = move_toward(parent.velocity.x, 0, 550 * delta)
	
	if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		return run_state
	
	if Input.is_action_just_pressed("jump"):
		return jump_state

func process_frame(delta):
	if parent.velocity.y > 0:
		return fall_state
