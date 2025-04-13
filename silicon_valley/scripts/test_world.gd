extends Node3D

@onready var enemy_weapon: Weapon = $EnemyBase/EnemyWeapon
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	enemy_weapon.set_damage(10)

func _process(_delta: float) -> void:
	if enemy_weapon:
		animation_player.play("rotate_enemy_weapon")
