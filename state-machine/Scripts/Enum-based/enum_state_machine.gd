extends CharacterBody2D

# states the player can be in
enum state {
	IDLE,
	RUN,
	JUMP,
	FALL,
	DASH
	}
	
var current_state: state = state.IDLE
var movement

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

var speed = 120
var jump_vel = -250
var acceleration = 1000
var friction = 550
var air_accel = 400
var air_resist = 200

func _physics_process(delta: float) -> void:
	movement = Input.get_axis("move_left","move_right")
	
	print(current_state)
	
	# flips character
	if movement:
		anim.flip_h = movement < 0
	
	# applies gravity
	if not is_on_floor():
		velocity += get_gravity() * 0.9 * delta
	
	match (current_state):
		state.IDLE:
			#logic
			# character moves to a stop
			velocity.x = move_toward(velocity.x, 0, friction * delta)
			anim.play("idle")
			friction = 550 # reset friction
			
			# checks
			if movement:
				current_state = state.RUN
			elif Input.is_action_just_pressed("jump"):
				current_state = state.JUMP
			if velocity.y > 0:
				current_state = state.FALL
		state.RUN:
			#logic
			anim.play("run")
			velocity.x = move_toward(velocity.x, speed * movement, acceleration * delta)
			
			#checks
			if movement == 0:
				current_state = state.IDLE
			elif Input.is_action_just_pressed("jump"):
				current_state = state.JUMP
			if velocity.y > 0:
				current_state = state.FALL
			elif Input.is_action_just_pressed("dash"):
				current_state = state.DASH
		state.JUMP:
			#logic
			if is_on_floor():
				velocity.y = jump_vel
				anim.play("jump")
				
				# short hop
			elif not is_on_floor():
				if Input.is_action_just_released("jump") and velocity.y < jump_vel / 2:
					velocity.y = jump_vel / 2
			# air accel and resist
			if movement != 0:
				velocity.x = move_toward(velocity.x, speed * movement, air_accel * delta)
			velocity.x = move_toward(velocity.x, 0, air_resist * delta)
			
			#checks
			if velocity.y > 0:
				current_state = state.FALL
		state.FALL:
			#logic
			anim.play("fall")
			# air accel and resist
			if movement != 0:
				velocity.x = move_toward(velocity.x, speed * movement, air_accel * delta)
			velocity.x = move_toward(velocity.x, 0, air_resist * delta)
			
			
			#checks
			if is_on_floor():
				current_state = state.IDLE
		state.DASH:
			anim.play("dash")
			velocity.x = movement * 250
			await get_tree().create_timer(0.1).timeout
			anim.play("dash")
			friction = 50 # less friction on exit
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
