extends StaticBody3D

@export var stone = 3
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_interactable_focused(interactor: Interactor) -> void:
	$InteractPrompt.visible = true


func _on_interactable_interacted(interactor: Interactor) -> void:
	Inventory.stone += 1
	stone -= 1
	if stone <= 0:
		$Interactable.active = false


func _on_interactable_unfocused(interactor: Interactor) -> void:
	$InteractPrompt.visible = false
