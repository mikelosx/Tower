extends StaticBody3D
class_name Gatherable

@export var delete_on_finished = false
@export var quantity = 3
@export var wood = false
@export var stone = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


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
	if quantity <= 0:
		_resource_depleted()


func _resource_depleted():
	if delete_on_finished: queue_free()
	else: $Interactable.active = false
