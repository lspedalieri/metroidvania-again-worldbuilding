class_name PlayerStateRun extends PlayerState


# what happens when we enter this state
func init() -> void:
	pass


# what happens when we enter this state
func enter() -> void:
	# play animation
	player.animation_player.play("run")
	pass


# what happens when we exit this state
func exit() -> void:
	pass

# what happens when an input is pressed
func handle_input( _event: InputEvent) -> PlayerState:
	if _event.is_action_pressed("jump"):
		return jump
	return next_state

# what happens each process tick in this state
func process(_delta: float) -> PlayerState:
	if player.direction.x == 0.0:
		return idle
	elif player.direction.y > 0.5:
		return crouch
	return next_state

# what happens each physics_process tick in this state
func physics_process(_delta: float) -> PlayerState:
	player.velocity.x = player.direction.x * player.move_speed
	if not player.is_on_floor():
		return fall
	return next_state
