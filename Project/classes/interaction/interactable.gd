extends Area3D
class_name Interactable

signal interacted(interactor: Interactor)
signal focused(interactor: Interactor)
signal unfocused(interactor: Interactor)


func active(x: bool):
	$CollisionShape3D.disabled = !x
