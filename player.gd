extends CharacterBody3D


const SPEED = 1.0
const SPEED_LIMIT = 5.0
const AIR_CONTROL = 3.0
const JUMP = 6.0
@onready var cam := $Camera3D


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			rotate_y(-event.relative.x * 0.01)
			cam.rotate_x(-event.relative.y * 0.01)
			cam.rotation.x = clamp(cam.rotation.x, deg_to_rad(-90), deg_to_rad(60))


func _physics_process(delta: float) -> void:
	velocity = _calculate_velocity(velocity, delta)
	move_and_slide()


func _calculate_velocity(v, delta):
	if !is_on_floor():
		v += get_gravity() * delta
	if Input.is_action_just_pressed("jump") and is_on_floor():
		v.y = JUMP
	
	var input_dir := Input.get_vector("left", "right", "foward", "back")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		if Input.is_action_just_pressed("jump") and !is_on_floor():
			v.y = 0
		v.x += direction.x * SPEED
		v.z += direction.z * SPEED
	elif is_on_floor():
		v.x -= move_toward(v.x, 0, SPEED)
		v.z -= move_toward(v.z, 0, SPEED)
	
	#if !is_on_floor():
		#v += get_gravity() * delta
	#if Input.is_action_just_pressed("jump") and is_on_floor():
		#v.y = JUMP
	#
	#var input_dir := Input.get_vector("left", "right", "foward", "back")
	#var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	#if !is_on_floor():
		#direction /= AIR_CONTROL
	#
	#if direction:
		#print("z = " + str(v.z) + " | x = " + str(v.x))
		#
		#if v.x <= SPEED_LIMIT and v.x >= -SPEED_LIMIT:
			#v.x += direction.x * SPEED
		#if v.z <= SPEED_LIMIT and v.z >= -SPEED_LIMIT:
			#v.z += direction.z * SPEED
		#if v.z > SPEED_LIMIT or v.z < -SPEED_LIMIT: v.z -= move_toward(v.z, 0, SPEED)
		#if v.x > SPEED_LIMIT or v.x < -SPEED_LIMIT: v.x -= move_toward(v.x, 0, SPEED)
	#else:
		#v.x -= move_toward(v.x, 0, SPEED)
		#v.z -= move_toward(v.z, 0, SPEED)
	
	
	return v
