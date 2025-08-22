extends CharacterBody2D

# states the player can be in
enum state {
	IDLE,
	RUN,
	JUMP,
	FALL
	}
	
var current_state: state = state.IDLE
var movement

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

var speed = 120
var jump_vel = -250

func _physics_process(delta: float) -> void:
	movement = Input.get_axis("move_left","move_right")
	
	print(current_state)
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if movement:
		anim.flip_h = movement < 0
	
	match (current_state):
		state.IDLE:
			# character moves to a stop
			velocity.x = move_toward(velocity.x, 0, 500 * delta)
			anim.play("idle")
			
			# checks
			if movement:
				current_state = state.RUN
			elif Input.is_action_just_pressed("jump"):
				current_state = state.JUMP
		state.RUN:
			anim.play("run")
			velocity.x = move_toward(velocity.x, speed * movement, 1000 * delta)
			
			#checks
			if movement == 0:
				current_state = state.IDLE
			elif Input.is_action_just_pressed("jump"):
				current_state = state.JUMP
			if velocity.y > 0:
				current_state = state.FALL
		state.JUMP:
			if is_on_floor():
				velocity.y += jump_vel
				anim.play("jump")
			
			#checks
			if not is_on_floor():
				current_state = state.FALL
		state.FALL:
			anim.play("fall")
			
			#checks
			if is_on_floor():
				current_state = state.IDLE
	
	move_and_slide()

func idling():
	if movement == 0:
		current_state = state.IDLE
	elif movement != 0:
		current_state = state.RUN
	elif Input.is_action_just_pressed("jump"):
		current_state = state.JUMP

func handle_run(delta, movement):
	velocity.x += movement * 100 * delta
	#move_toward(velocity.x, speed, 1000 * delta)
	if movement == 0:
		current_state = state.IDLE
		
	elif Input.is_action_just_pressed("jump"):
		current_state = state.JUMP

func handle_jump(delta, movement):
	velocity.y += jump_vel
	current_state = state.FALL
	if is_on_floor():
		current_state = state.IDLE
