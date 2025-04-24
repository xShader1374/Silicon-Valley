@tool
extends Node3D
class_name Enemy

@onready var collision_shape_3d: CollisionShape3D = $CharacterBody3D/CollisionShape3D
@onready var mesh_instance_3d: MeshInstance3D = $CharacterBody3D/MeshInstance3D

@export var shape: Shape3D
@export var mesh: Mesh
@export var max_health: int = 100

var health: int = 0

func _ready() -> void:
	collision_shape_3d.shape = shape
	mesh_instance_3d.mesh = mesh
	health = max_health

func take_damage(amount: int) -> void:
	health -= amount
	
	if health <= 0:
		die()

func die() -> void:
	queue_free()


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("weapons"):
		var weapon: Weapon = body.get_parent()
		take_damage(weapon.damage)


func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.is_in_group("weapons"):
		var weapon: Weapon = area.get_parent()
		take_damage(weapon.damage)
