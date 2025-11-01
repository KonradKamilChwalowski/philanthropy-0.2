extends Control

@onready var background = $Background
@onready var cards_container = $CardsContainer
@onready var resource_card_scene := preload("res://cards_and_dices/resource_card.tscn")
@onready var new_round_button: Button = $NewRoundButton
@onready var player_interfaces: Control = $PlayerInterfaces
@onready var resolution_label : Label = $ResolutionLabel

func _ready() -> void:
	await ResolutionManager.resolution_ready
	scale = ResolutionManager.current_scale_vector
	resolution_label.text = str(ResolutionManager.screen_size)
	new_round()

func new_round() -> void:
	GameManager.current_round += 1
	new_round_button.text = "Runda: " + str(GameManager.current_round) + "\nDALEJ"
	draw_new_cards()
	throw_dices()

func draw_new_cards() -> void:
	for child in cards_container.get_children():
		child.queue_free()
	
	for i in 5:
		var card = resource_card_scene.instantiate()
		card.card_id = i
		var random_type_id = randi() % 5
		match random_type_id:
			0:
				card.resource_type = "Money"
			1:
				card.resource_type = "Materials"
			2:
				card.resource_type = "Space"
			3:
				card.resource_type = "Energy"
			4:
				card.resource_type = "Tools"
		cards_container.add_child(card)

func throw_dices() -> void:
	for interface in player_interfaces.get_children():
		interface.roll_dices()


func _on_new_round_button_pressed() -> void:
	new_round()
