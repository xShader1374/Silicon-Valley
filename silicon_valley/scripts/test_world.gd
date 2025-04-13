extends Node3D

@onready var enemy_weapon: Weapon = $EnemyBase/EnemyWeapon

func _process(delta: float) -> void:
	enemy_weapon.set_damage(10)
	enemy_weapon.rotate_x(-0.05)
