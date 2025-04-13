@tool
extends Node3D
class_name Weapon

@onready var weapon: Weapon = $"."
@onready var timer: Timer = $Timer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collision_shape_3d: CollisionShape3D = $RigidBody3D/CollisionShape3D
@onready var mesh_instance_3d: MeshInstance3D = $RigidBody3D/MeshInstance3D

@export var base_damage: int = 10
@export var shape: Shape3D
@export var mesh: Mesh
@export var collision_pos: Vector3

var damage: int = 0

var is_attacking: bool = false
var is_defending: bool = false

func _ready() -> void:
	collision_shape_3d.shape = shape
	mesh_instance_3d.mesh = mesh
	collision_shape_3d.position = collision_pos

func set_damage(amount: int) -> void:
	damage = amount

func attack() -> void:
	if !is_defending:
		is_attacking = true
		damage = base_damage
		animation_player.play("hit")

func defend() -> void:
	if !is_attacking:
		is_defending = true
		animation_player.play("defend")

func default() -> void:
	if is_attacking:
		animation_player.play("hit_reset")
	if is_defending:
		animation_player.play("defend_reset")
	
	is_attacking = false
	is_defending = false
	
	damage = 0
