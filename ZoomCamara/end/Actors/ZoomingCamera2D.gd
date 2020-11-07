class_name ZoomingCamera2D
extends Camera2D

export var tween_duration := 0.2
export var zoom_factor := 0.1
export var min_zoom := 0.5
export var max_zoom := 2.0

var _zoom_level := 1.0 setget _set_zoom_level

onready var tween : Tween = $Tween

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("zoom_in"):
		_set_zoom_level(_zoom_level - zoom_factor)
	elif event.is_action_pressed("zoom_out"):
		_set_zoom_level(_zoom_level + zoom_factor)


func _set_zoom_level(value: float) -> void:
	_zoom_level = clamp(value, min_zoom, max_zoom)
	tween.interpolate_property(
		self,
		"zoom",
		zoom,
		_zoom_level * Vector2.ONE,
		tween_duration,
		tween.TRANS_SINE,
		tween.EASE_OUT
	)
	tween.start()
