class_name PlayerState
extends State

@export var animation_name: String

@export var speed = 120

var parent: Player

func enter():
	parent.animations.play(animation_name)
