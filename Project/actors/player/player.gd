extends CharacterBody3D


const SPEED = 0.1
const SPEED_LIMIT = 15.0
const DASH_SPEED = 20.0
const AIR_RESISTANCE = 6.0
const WEIGHT = 2.0
const JUMP = 15.0
const TOTAL_DASHES = 1

@onready var cam := $Camera3D
@onready var ray := $Camera3D/RayCast3D

var dashing = false
var dash_off_cooldown = true
var dash_count = 1


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("build_menu"): _build_menu()
	
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
	
	if Input.is_action_just_pressed("jump") and dashing:
		$DashDuration.stop()
		dashing = false
	
	
	if !is_on_floor():
		v += get_gravity() * delta * WEIGHT
	else:
		dash_count = TOTAL_DASHES
		if Input.is_action_just_pressed("jump"):
			v.y = JUMP
	
	if Input.is_action_just_pressed("dash") and direction:
		if dash_off_cooldown and dash_count > 0:
			v = direction * DASH_SPEED
			$DashDuration.start()
			dashing = true
			$DashCooldown.start()
			dash_off_cooldown = false
			if !is_on_floor():
				dash_count -= 1
	
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


func _build_menu():
	pass
func _on_dash_duration_timeout() -> void:
	dashing = false


func _on_dash_cooldown_timeout() -> void:
	dash_off_cooldown = true
