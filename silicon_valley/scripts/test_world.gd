extends SubViewportContainer

@onready var enemy_weapon: Weapon = $SubViewport/test_world/EnemyBase/EnemyWeapon
@onready var animation_player: AnimationPlayer = $SubViewport/test_world/AnimationPlayer

func _ready() -> void:
	enemy_weapon.set_damage(10)

func _process(_delta: float) -> void:
	if enemy_weapon:
		animation_player.play("rotate_enemy_weapon")
