class_name PlayerState
extends State

@export var animation_name: String

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var speed = 120

var parent: Player

func enter():
	parent.animations.play(animation_name)
	
func process_physics(delta):
	parent.move_and_slide()
