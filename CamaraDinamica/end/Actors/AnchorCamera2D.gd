class_name AnchorCamera2D
extends Camera2D

const SLOW_RADIUS := 300.0

export var max_speed := 2000.0
export var mass := 2.0

var _velocity = Vector2.ZERO
var _anchor_position := Vector2.ZERO
var _target_zoom := 1.0

func _ready() -> void:
	set_as_toplevel(true)


func _physics_process(delta: float) -> void:
	update_zoom()
	
	if _anchor_position.is_equal_approx(Vector2.ZERO):
		arrive_to(owner.global_position)
	else:
		arrive_to(_anchor_position)


func update_zoom() -> void:
	if not is_equal_approx(zoom.x, _target_zoom):
		var new_zoom_level = lerp(zoom.x, _target_zoom, 1.0 - pow(0.008,get_physics_process_delta_time()))
		zoom = Vector2(new_zoom_level, new_zoom_level)


func arrive_to(target_position : Vector2) -> void:
	var distance_to_target := position.distance_to(target_position)
	var desired_velocity := (target_position - position).normalized() * max_speed * zoom.x
	if distance_to_target < SLOW_RADIUS * zoom.x:
		desired_velocity *= (distance_to_target/ (SLOW_RADIUS * zoom.x))
	_velocity += (desired_velocity - _velocity) / mass
	position += _velocity * get_physics_process_delta_time()



func _on_AnchorDetector2D_anchor_detached() -> void:
	_anchor_position = Vector2.ZERO
	_target_zoom = 1.0




func _on_AnchorDetector2D_anchor_dected(anchor) -> void:
	_anchor_position = anchor.global_position
	_target_zoom = anchor.zoom_level
