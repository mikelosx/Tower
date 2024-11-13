extends Control


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$LblWood.text = ("wood: " + str(get_parent().inv.wood))
	$LblStone.text = ("stone: " + str(get_parent().inv.stone))
	$LblTOre.text = ("TOre: " + str(get_parent().inv.t_ore))
