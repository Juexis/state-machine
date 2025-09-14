extends State

@export var run_state: State

func enter():
	super()
	

func process_input(input):
	var input_axis = Input.get_axis("move_left","move_right")
	
	if(input_axis):
		return run_state
