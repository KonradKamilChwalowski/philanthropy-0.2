class_name PlayerInterface extends Control

@export var player_color: Color = Color(255,255,255)

@onready var color_rect: ColorRect = $ColorRect
@onready var resources_container := $ResourcesContainer
@onready var resources_buttons_array: Array = []
@onready var slider: Slider = $SliderDicesContainer/HSlider
@onready var dice0: Dice = $SliderDicesContainer/Dice0
@onready var dice1: Dice = $SliderDicesContainer/Dice1
@onready var dice2: Dice = $SliderDicesContainer/Dice2

var interface_activ_element_type: String # resource / slider / dice
var interface_activ_element_id: int = 0
var is_change_for_more: bool = true
var dice_number: int = 2

func _ready() -> void:
	color_rect.color = player_color
	for btn in resources_container.get_children():
		resources_buttons_array.append(btn)

func roll_dices() -> void:
	dice0.throw_me()
	dice1.throw_me()
	dice2.throw_me()

func change_value_of_element() -> void:
	match interface_activ_element_type:
		"resource":
			var lbl = resources_buttons_array[interface_activ_element_id].get_children()[1]
			var value = int(lbl.text)
			if is_change_for_more:
				lbl.text = str(value + 1)
			else:
				lbl.text = str(value - 1)
		"slider":
			if is_change_for_more:
				slider.value += 1
				slider.value = min(6, slider.value)
			else:
				slider.value -= 1
				slider.value = max(-6, slider.value)
		"dice":
			if is_change_for_more:
				dice_number += 1
				dice_number = min(3, dice_number)
			else:
				dice_number -= 1
				dice_number = max(0, dice_number)
			match dice_number:
				0:
					dice0.visible = false
				1:
					dice0.visible = true
					dice1.visible = false
				2:
					dice1.visible = true
					dice2.visible = false
				3:
					dice2.visible = true

func _on_money_button_pressed() -> void:
	interface_activ_element_type = "resource"
	interface_activ_element_id = 0

func _on_materials_button_pressed() -> void:
	interface_activ_element_type = "resource"
	interface_activ_element_id = 1

func _on_space_button_pressed() -> void:
	interface_activ_element_type = "resource"
	interface_activ_element_id = 2

func _on_energy_button_pressed() -> void:
	interface_activ_element_type = "resource"
	interface_activ_element_id = 3

func _on_tools_button_pressed() -> void:
	interface_activ_element_type = "resource"
	interface_activ_element_id = 4

func _on_slider_button_pressed() -> void:
	interface_activ_element_type = "slider"
	interface_activ_element_id = 0

func _on_dice_button_pressed() -> void:
	interface_activ_element_type = "dice"

func _on_less_button_pressed() -> void:
	is_change_for_more = false
	change_value_of_element()

func _on_more_button_pressed() -> void:
	is_change_for_more = true
	change_value_of_element()
