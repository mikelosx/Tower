extends Slave


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	speed_lvl = 3
	inventory_lvl = 3


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if !nav.is_target_reached():
		var current_location = global_transform.origin
		var next_location = nav.get_next_path_position()
		var new_velocity = (next_location - current_location).normalized() * speed * delta
		velocity = new_velocity
		move_and_slide()
	else:
		print("testdgfu9wehfgoi")
		$Interactor.interact($Interactor.get_closest_interactable())
