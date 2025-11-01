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

func change_resolution(new_resolution: Vector2i = Vector2i(1920, 1080)) -> void:
	if not OS.has_feature("web"):
		get_window().size = new_resolution
	var base := Vector2(1920.0, 1080.0)
	var ratio := Vector2(new_resolution.x / base.x, new_resolution.y / base.y)
	current_scale = min(ratio.x, ratio.y)
	current_scale_vector = ratio
	screen_size = Vector2i(new_resolution)
	get_window().content_scale_factor = current_scale
