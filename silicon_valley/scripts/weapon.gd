extends Node3D
class_name Weapon

@onready var weapon: Weapon = $"."
@onready var timer: Timer = $Timer

@export var base_damage: int = 10
@export var damage: int = 0

var default_rotation: Vector3

var is_attacking: bool = false
var is_defending: bool = false

func _ready() -> void:
	default_rotation = weapon.rotation

func set_damage(amount: int):
	damage = amount

func attack():
	if !is_defending:
		is_attacking = true
		
		damage = base_damage
		
		weapon.rotate_x(-45)
		weapon.rotate_z(45)

func defend():
	if !is_attacking:
		is_defending = true
		
		weapon.rotate_z(45)

func default():
	is_attacking = false
	is_defending = false
	
	damage = 0
	
	weapon.rotation = default_rotation
