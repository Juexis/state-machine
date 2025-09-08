extends PlayerState

@export
var idle_state: PlayerState

@export
var jump_state: PlayerState

@export
var fall_state: PlayerState

@export
var dash_state: PlayerState

@export var acceleration = 1000
@export var friction = 550

func process_input(event):
	if Input.is_action_just_pressed("jump"):
		return jump_state


func process_physics(delta):
	var input_axis = Input.get_axis("move_left", "move_right")
	parent.velocity.x = move_toward(parent.velocity.x, speed * input_axis, acceleration * delta)
	
	parent.move_and_slide()
	
	if input_axis == 0:
		return idle_state
