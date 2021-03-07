class_name AnchorDetector2D
extends Area2D

signal anchor_dected(anchor)
signal anchor_detached


func _on_AnchorDetector2D_area_entered(area: Anchor2D) -> void:
	emit_signal("anchor_dected", area)


func _on_AnchorDetector2D_area_exited(area: Anchor2D) -> void:
	if get_overlapping_areas().size() == 0:
		emit_signal("anchor_detached")
