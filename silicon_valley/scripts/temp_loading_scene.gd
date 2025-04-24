extends Control

@export var next_scene: PackedScene = preload("uid://cs4drhmc1bql5")
@export var phrases: Array[String] = [
	"If you want your car you have to search it."
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%textLabel.text = phrases.pick_random()
	
	await writingAnimation()
	
	await get_tree().create_timer(1.5, true, false, true).timeout
	
	get_tree().change_scene_to_packed(next_scene)

func writingAnimation() -> void:
	var tween: Tween = create_tween()
	
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_LINEAR)
	
	tween.tween_property(%textLabel, "visible_ratio", 1.0, 1.5)
	
	await tween.finished
