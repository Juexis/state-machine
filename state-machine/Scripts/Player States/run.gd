extends State

@export var idle_state: State

@export var jump_state: State

@export var fall_state: State

var speed: int = 120
var acceleration: int = 700

func process_input(input):
	if Input.is_action_just_pressed("jump"):
		return jump_state
	
	if parent.velocity.y > 0:
		return fall_state

func process_physics(delta):
	var input_axis: float = Input.get_axis("move_left","move_right")
	
	if input_axis:
		parent.velocity.x = move_toward(parent.velocity.x, speed * input_axis, acceleration * delta)
		
		# handle character flipping
		parent.animations.flip_h = input_axis < 0
	
	if !input_axis:
		parent.velocity.x = move_toward(parent.velocity.x, 0, 450 * delta)
		
		# wait until friction is done
		if parent.velocity.x == 0:
			return idle_state
