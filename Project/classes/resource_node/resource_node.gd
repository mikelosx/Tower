extends StaticBody3D
class_name ResourceNode

@export var delete_on_depleted = false
#var hide_on_depleted = false
@export var regen_time = 60.0
@export var quantity = 3
var max_quantity: int
@export var wood = false
@export var stone = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$RegenTimer.wait_time = regen_time
	max_quantity = quantity


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_interactable_focused(interactor: Interactor) -> void:
	$InteractPrompt.visible = true


func _on_interactable_unfocused(interactor: Interactor) -> void:
	$InteractPrompt.visible = false


func _on_interactable_interacted(interactor: Interactor) -> void:
	if wood: Inventory.wood += 1
	else: Inventory.stone += 1
	quantity -= 1
	if $RegenTimer.is_stopped: $RegenTimer.start()
	
	if quantity <= 0:
		_resource_depleted()


func _resource_depleted():
	if delete_on_depleted: queue_free()
	#elif hide_on_depleted: visible = false
	else: $Interactable.active(false)


func _resource_regenerated():
	#if hide_on_depleted: visible = true
	$Interactable.active(true)


func _on_regen_timer_timeout() -> void:
	print("pass")
	quantity += 1
	_resource_regenerated()
	if quantity >= max_quantity:
		$RegenTimer.stop()
