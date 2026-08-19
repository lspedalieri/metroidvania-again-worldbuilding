class_name PlayerStateIdle extends PlayerState


# what happens when we enter this state
func init() -> void:
	pass


# what happens when we enter this state
func enter() -> void:
	player.coyote_timer = player.coyote_time
	player.animation_player.play("idle")
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
	if player.direction.x != 0.0:
		return run
	elif player.direction.y > 0.5:
		return crouch
	return null

# what happens each physics_process tick in this state
func physics_process(_delta: float) -> PlayerState:
	player.velocity.x = 0
	if not player.is_on_floor():
		return fall
	return next_state
