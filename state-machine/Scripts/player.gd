class_name Player
extends CharacterBody2D

@onready
var animations: AnimatedSprite2D = $AnimatedSprite2D

@onready
var state_machine: Node = $state_machine

func _ready() -> void:
	state_machine.init(self)

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	velocity += get_gravity() * 0.9 * delta # apply gravity before state logic
	state_machine.process_physics(delta)
	move_and_slide()
	#print(velocity)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)
