extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animateFadeIn()


func animateFadeIn() -> void:
	var tween: Tween = create_tween()
	
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_EXPO)
	
	tween.tween_property(self, "modulate", Color.WHITE, 0.5).from(Color.BLACK)
