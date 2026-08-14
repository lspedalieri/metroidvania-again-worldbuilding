@icon("res://player/states/state.svg")
class_name PlayerStateCrouch extends PlayerState


# what happens when we enter this state
func init() -> void:
	pass


# what happens when we enter this state
func enter() -> void:
	player.sprite.scale.y = 0.625
	player.sprite.position.y = -15
	player.collision_stand.disabled = true
	player.collision_crouch.disabled = false
	pass


# what happens when we exit this state
func exit() -> void:
	player.sprite.scale.y = 1
	player.sprite.position.y = -24
	player.collision_stand.disabled = false
	player.collision_crouch.disabled = true
	pass

# what happens when an input is pressed
func handle_input( _event: InputEvent) -> PlayerState:
	if _event.is_action_pressed("jump"):
		if player.one_way_platform_raycast.is_colliding():
			player.position.y += 4
			return fall
		return jump
	return next_state

# what happens each process tick in this state
func process(_delta: float) -> PlayerState:
	if player.direction.y <= 0.5:
		return idle
	return next_state

# what happens each physics_process tick in this state
func physics_process(_delta: float) -> PlayerState:
	player.velocity.x -= player.velocity.x * player.deceleration_rate * _delta
	if not player.is_on_floor():
		return fall
	return next_state
