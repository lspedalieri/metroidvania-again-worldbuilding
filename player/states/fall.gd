class_name PlayerStateFall extends PlayerState


@export var fall_gravity_multiplier: float = 1.165

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func init() -> void:
	pass

func enter() -> void:
	player.gravity_multiplier = fall_gravity_multiplier
	if player.previous_state == jump:
		player.coyote_timer = 0
	else:
		player.coyote_timer = player.coyote_time
	pass

func exit() -> void:
	player.gravity_multiplier = 1.0

# what happens when an input is pressed
func handle_input( _event: InputEvent) -> PlayerState:
	if _event.is_action_pressed("jump"):
		if player.coyote_timer > 0.0:
			return jump
		else:
			player.jump_buffer_timer = player.jump_buffer_time
	return next_state

# Called every frame. 'delta' is the elapsed time since the previous frame.
func process(_delta: float) -> PlayerState:
	player.coyote_timer -= _delta
	player.jump_buffer_timer -= _delta
	set_jump_frame()
	return next_state


# what happens each physics_process tick in this state
func physics_process(_delta: float) -> PlayerState:
	if player.is_on_floor():
		player.add_debug_indicator()
		if player.jump_buffer_timer > 0:
			return jump
		return idle
	#consente di cambiare il movimento in aria
	player.velocity.x = player.direction.x * player.move_speed
	return next_state

func set_jump_frame() -> void:
	var frame: float = remap(player.velocity.y, 0.0, player.max_fall_velocity, 0.5, 1.0)
	player.animation_player.seek(frame, true)
	pass
