extends Control


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$LblWood.text = ("wood: " + str(Town.wood))
	$LblStone.text = ("stone: " + str(Town.stone))
	$LblTOre.text = ("TOre: " + str(Town.TOre))
