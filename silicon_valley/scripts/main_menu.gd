extends Control

@export var level_name: String = "Main Menu"
@export var new_game_loader_scene: PackedScene = preload("uid://b1p5ql16mdrh0")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.current_level_name = level_name
	
	animateFadeIn()
	showAnimation(%buttonsPanelContainer)
	showAnimation(%titleLabel, 1.0)

func showAnimation(node: Node, duration: float = 0.5) -> void:
	node.pivot_offset = node.size / 2.0
	
	var tween: Tween = create_tween()
	
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_EXPO)
	
	tween.tween_property(node, "scale:y", 1.0, duration).from(0.0)
	tween.parallel().tween_property(node, "scale:x", 1.0, duration).from(0.0).set_delay(0.075)

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


func _on_new_game_button_pressed() -> void:
	get_tree().change_scene_to_packed(new_game_loader_scene)
