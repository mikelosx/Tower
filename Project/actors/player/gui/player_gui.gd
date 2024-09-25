extends Control


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$LblWood.text = ("wood: " + str(Inventory.wood))
	$LblStone.text = ("stone: " + str(Inventory.stone))
	$LblTOre.text = ("TOre: " + str(Inventory.tower_ore))
