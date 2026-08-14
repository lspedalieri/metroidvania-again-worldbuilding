class_name PlayerStateJump extends PlayerState


# what happens when we enter this state
func init() -> void:
	pass


# what happens when we enter this state
func enter() -> void:
	#player.add_debug_indicator(Color.LIME_GREEN)
	player.animation_player.play("jump")
	player.velocity.y = -player.jump_velocity
	pass


# what happens when we exit this state
func exit() -> void:
	#player.add_debug_indicator(Color.YELLOW)
	pass

# what happens when an input is pressed
func handle_input( event: InputEvent) -> PlayerState:
	if event.is_action_released("jump"):
		player.velocity.y *= 0.5
		return fall
	return next_state

# what happens each process tick in this state
func process(_delta: float) -> PlayerState:
	return next_state

# what happens each physics_process tick in this state
func physics_process(_delta: float) -> PlayerState:
	if player.is_on_floor():
		return idle
	elif player.velocity.y >= 0:
		player
		return fall
	#consente di cambiare il movimento in aria
	player.velocity.x = player.direction.x * player.move_speed
	return next_state
