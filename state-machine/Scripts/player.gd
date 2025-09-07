class_name Player
extends CharacterBody2D
# script just delegates state-based logic to the state machine

@onready
var animations: AnimatedSprite2D = $AnimatedSprite2D

@onready
var state_machine: Node = $state_machine

func ready() -> void:
	# initializes state machine node
	state_machine.init(self)
	print("hi")
	
func unhandled_input(event: InputEvent) -> void: 
	state_machine.process_input(event) #passes input to the state machine

func process_physics(delta: float) -> void:
	state_machine.process_physics(delta) #pass delta to state machine
	
func process(delta: float) -> void:
	state_machine.process_frame(delta) #pass delta to state machine
