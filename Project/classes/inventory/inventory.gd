extends Node
class_name Inventory


var stone = 0
var wood = 0
var t_ore = 0
var max = 3


func is_max() -> bool:
	return max < (stone + wood + t_ore)
