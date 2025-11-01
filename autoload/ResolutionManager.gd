extends Node

var current_scale: float = 1.0
var current_scale_vector: Vector2 = Vector2(1.0, 1.0)
var screen_size: Vector2i

func _ready() -> void:
	var current_screen := DisplayServer.window_get_current_screen()
	screen_size = DisplayServer.screen_get_size(current_screen)
	change_resoultion(screen_size)

func change_resoultion(new_resolution: Vector2i = Vector2i(1920, 1080)) -> void:
	get_window().size = new_resolution
	current_scale = float(new_resolution.x) / float(1920)
	current_scale_vector = Vector2(float(new_resolution.x) / float(1920), float(new_resolution.y) / float(1080))
