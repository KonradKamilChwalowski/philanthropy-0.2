class_name Dice extends Control 

@onready var color_rect := $ColorRect
@export var player_number: int = 1
@onready var label := $Label
@onready var dice_value: int = 1
var is_special: bool = false


func throw_me() -> void:
	dice_value = randi() % 6
	if dice_value != 0:
		label.text = str(int(dice_value))
	else:
		label.text = "!"
		is_special = true
