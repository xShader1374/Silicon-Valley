extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation_player.play("show_sponsors")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "show_sponsors":
		get_tree().change_scene_to_file("uid://dblo1acmeuiyl") # "res://scenes/Main_Menu/main_menu.tscn", main menu scene
