extends Node

@export var starting_state: State

var current_state: State

# Player is set as the parent, assigned as parent of all states
func init(parent: Player) -> void: #init is called when the script is initialized
	for child in get_children():
		child.parent = parent
		
	# initialize to default state
	change_state(starting_state)

func change_state(new_state: State) -> void:
	if current_state:
		current_state.exit() # if currently in state, exit
	
	current_state = new_state # change state to one passed in parameter
	current_state.enter()


func process_physics(delta: float) -> void:
	var new_state = current_state.process_physics(delta)
	if new_state:
		change_state(new_state)


func process_input(event: InputEvent) -> void:
	var new_state = current_state.process_input(event)
	if new_state:
		change_state(new_state)


func process_frame(delta: float) -> void:
	var new_state = current_state.process_frame(delta)
	if new_state:
		change_state(new_state)
