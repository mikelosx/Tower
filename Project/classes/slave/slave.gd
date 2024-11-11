extends CharacterBody3D
class_name Slave

const TIMESLICE = 60
var frame = 0

var speed = 100
var speed_lvl = 1
var inventory_lvl = 1
var attack_lvl = 1
var inv = Inventory.new()
var closest_node: StaticBody3D
@onready var nav = $NavigationAgent3D


func _ready() -> void:
	inv.max = inv.max * inventory_lvl
	speed *= speed_lvl


func _physics_process(delta: float) -> void:
	pass


func _process(delta: float) -> void:
	find_node()
	frame += 1


func update_target_location(target_location):
	nav.set_target_position(target_location)


func find_node():
	if frame < TIMESLICE: return
	else: frame = 0
	
	print("update target")
	var closest_node
	var distance: float = INF
	for n in get_tree().get_nodes_in_group("gather_node"): 
		if n.get_node("Interactable").active:
			if n.global_position.distance_to(global_position) < distance:
				closest_node = n
				distance = n.global_position.distance_to(position)
	
	if distance > nav.target_desired_distance:
		update_target_location(closest_node.global_position)
