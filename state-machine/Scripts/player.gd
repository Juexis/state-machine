class_name Player
extends CharacterBody2D
# script just delegates state-based logic to the state machine

@onready
var animations: AnimatedSprite2D = $AnimatedSprite2D

@onready
var state_machine: Node = $state_machine

func _ready() -> void:
	# initializes state machine node
	state_machine.init(self)
	
func _unhandled_input(event: InputEvent) -> void: 
	state_machine.process_input(event) #passes input to the state machine

func _physics_process(delta: float) -> void:
	velocity = get_gravity() * 3 * delta # weird imp
	state_machine.process_physics(delta) #pass delta to state machine
	print(velocity)
	move_and_slide()
	

func _process(delta: float) -> void:
	state_machine.process_frame(delta) #pass delta to state machine
