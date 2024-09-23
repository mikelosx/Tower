extends Interactor

@export var player: CharacterBody3D
var interactable: Interactable


func _ready() -> void:
	controller = player

func _physics_process(delta: float) -> void:
	var n: Interactable = get_closest_interactable()
	
	if n != interactable:
		if is_instance_valid(interactable):
			unfocus(interactable)
		if n:
			focus(n)
		interactable = n


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and is_instance_valid(interactable):
		interact(interactable)


func _on_area_exited(area: Interactable) -> void:
	if interactable == area:
		unfocus(area)
