extends CharacterBody3D


const SPEED = 0.1
const SPEED_LIMIT = 15.0
const DASH_SPEED = 20.0
const AIR_RESISTANCE = 6.0
const WEIGHT = 2.0
const JUMP = 15.0

@onready var cam := $Camera3D

var dashing = false

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
	var input_dir := Input.get_vector("left", "right", "foward", "back")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if !is_on_floor():
		v += get_gravity() * delta * WEIGHT
		if Input.is_action_just_pressed("jump") and direction:
			v = direction * DASH_SPEED
			dashing = true
			$DashDuration.start()
	else:
		if Input.is_action_just_pressed("jump"):
			v.y = JUMP
	
	if dashing:
		v.y = 0.0
	
	if is_on_floor():
		if direction:
			v.x = lerpf(v.x, direction.x * SPEED_LIMIT, SPEED)
			v.z = lerpf(v.z, direction.z * SPEED_LIMIT, SPEED)
		else:
			v.x = lerpf(v.x, 0, SPEED)
			v.z = lerpf(v.z, 0, SPEED)
	else:
		var s = SPEED / AIR_RESISTANCE
		if direction:
			v.x = lerpf(v.x, direction.x * SPEED_LIMIT, s)
			v.z = lerpf(v.z, direction.z * SPEED_LIMIT, s)
		else:
			v.x = lerpf(v.x, 0, s)
			v.z = lerpf(v.z, 0, s)
	
	return v


func _on_dash_duration_timeout() -> void:
	dashing = false
