extends Control

@export_enum("Money", "Materials", "Space", "Energy", "Tools") var resource_type: String = "Money"
var names_array: Array = ["Pieniądze", "Materiały", "Przestrzeń", "Energia", "Narzędzia"]
@onready var name_label := $NameLabel
@onready var card_picture := $CardPicture
@onready var value_label := $ValueLabel
var card_id: int = 0
var card_picture_folder_path: String = "res://art/icons/"
var random_value: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	match resource_type:
		"Money":
			card_picture.texture = load(card_picture_folder_path.path_join("money.png"))
			random_value = 2*int(randi() % 3 + 3)
			name_label.text = names_array[0]
		"Materials":
			card_picture.texture = load(card_picture_folder_path.path_join("materials.png"))
			random_value = 2*int(randi() % 3) + 2
			name_label.text = names_array[1]
		"Space":
			card_picture.texture = load(card_picture_folder_path.path_join("space.png"))
			random_value = 2*int(randi() % 3) + 2
			name_label.text = names_array[2]
		"Energy":
			card_picture.texture = load(card_picture_folder_path.path_join("energy.png"))
			random_value = 2*int(randi() % 3) + 2
			name_label.text = names_array[3]
		"Tools":
			card_picture.texture = load(card_picture_folder_path.path_join("tools.png"))
			random_value = 2*int(randi() % 3) + 2
			name_label.text = names_array[4]
	value_label.text = "Wartość: " + str(random_value)
