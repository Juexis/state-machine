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

func process_physics(delta):
	move_toward(parent.velocity.x, speed * input_axis, acceleration * delta)
