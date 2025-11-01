extends Node

var current_scale: float = 1.0
var current_scale_vector: Vector2 = Vector2(1.0, 1.0)
var screen_size: Vector2i
signal resolution_ready

func _ready() -> void:
	await get_tree().process_frame
	change_resolution(get_viewport().get_visible_rect().size.floor())
	get_window().size_changed.connect(func():
		change_resolution(get_viewport().get_visible_rect().size.floor())
	)
	emit_signal("resolution_ready")

func change_resolution(new_resolution: Vector2i) -> void:
	var win := get_window()
	win.content_scale_mode = Window.CONTENT_SCALE_MODE_VIEWPORT
	win.content_scale_aspect = Window.CONTENT_SCALE_ASPECT_KEEP  # letterbox + centrowanie

	var base := Vector2(1920.0, 1080.0)
	var ratio := Vector2(new_resolution.x / base.x, new_resolution.y / base.y)
	var factor: float = min(ratio.x, ratio.y)  # KLUCZ: najmniejszy współczynnik

	current_scale = factor
	current_scale_vector = ratio
	screen_size = Vector2i(new_resolution)
	win.content_scale_factor = factor
