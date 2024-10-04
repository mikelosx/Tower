extends Node3D

@export var text: String

func _ready() -> void:
	visible = false
	$Label3D.text = text
