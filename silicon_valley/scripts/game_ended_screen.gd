extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	showAnimation()


func showAnimation() -> void:
	%VBoxContainer.pivot_offset = %VBoxContainer.size / 2.0
	
	var tween: Tween = create_tween()
	
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_EXPO)
	
	tween.tween_property(%VBoxContainer, "scale:y", 1.0, 0.5).from(0.0)
	tween.parallel().tween_property(%VBoxContainer, "scale:x", 1.0, 0.5).from(0.0).set_delay(0.075)


func _on_v_box_container_resized() -> void:
	%VBoxContainer.pivot_offset = %VBoxContainer.size / 2.0
