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
	if input_axis:
		return run_state

func process_physics(delta):
	if !parent.is_on_floor():
		return fall_state
