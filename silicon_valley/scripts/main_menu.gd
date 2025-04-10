extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animateFadeIn()
	showAnimation(%buttonsPanelContainer)
	await get_tree().create_timer(0.15, true, false, true).timeout
	showAnimation(%titleLabel)

func showAnimation(node: Node) -> void:
	node.pivot_offset = node.size / 2.0
	
	var tween: Tween = create_tween()
	
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_EXPO)
	
	tween.tween_property(node, "scale:y", 1.0, 0.5).from(0.0)
	tween.parallel().tween_property(node, "scale:x", 1.0, 0.5).from(0.0).set_delay(0.075)

func animateFadeIn() -> void:
	var tween: Tween = create_tween()
	
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_EXPO)
	
	tween.tween_property(self, "modulate", Color.WHITE, 0.5).from(Color.BLACK)


func _on_quit_button_pressed() -> void:
	# TODO: Troll Quit
	get_tree().quit()


func _on_buttons_panel_container_resized() -> void:
	%buttonsPanelContainer.pivot_offset = %buttonsPanelContainer.size / 2.0
