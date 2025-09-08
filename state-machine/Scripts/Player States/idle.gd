extends PlayerState

@export
var run_state: PlayerState

@export
var jump_state: PlayerState

@export
var fall_state: PlayerState


func enter():
	super()

func process_input(event):
	var input_axis = Input.get_axis("move_left", "move_right")
	if input_axis:
		return run_state
	
	if Input.is_action_just_pressed("jump"):
		return jump_state

func process_physics(delta):
	
	if parent.velocity.y > 0:
		return fall_state
