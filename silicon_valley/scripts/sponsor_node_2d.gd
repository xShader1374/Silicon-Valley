extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation_player.play("show_sponsors")

func play_form_software_sfx() -> void:
	pass

func play_fried_fish_sfx() -> void:
	SfxPlayer.play(0)

func play_tubozzi_sfx() -> void:
	SfxPlayer.play(1)

func tubozziLabelAnimation() -> void:
	var tween: Tween = create_tween()
	
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_EXPO)
	
	tween.tween_property(%TubozziLabel, "position", Vector2(0.0, 0.0), 2.0).from( Vector2(0.0, -72.0) )

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "show_sponsors":
		get_tree().change_scene_to_file("uid://dblo1acmeuiyl") # "res://scenes/Main_Menu/main_menu.tscn", main menu scene
