class_name PlayerWeaponHandler
extends Node2D

@onready var primary_weapon_anchor = $PrimaryWeaponAnchor as Marker2D

@export var projectile_packed_scene : PackedScene = null

#TODO: REMOVE TEST SPEED

var TEST_SPEED : float = 300.0

func _process(_delta):
	fire_primary_weapon()


func fire_primary_weapon() -> void:
	if Input.is_action_just_pressed("fire"):
		var mouse_position : Vector2 = get_global_mouse_position()
		var entity_container : Node2D = get_tree().get_first_node_in_group("entity_container")
		
		if entity_container == null:
			return
		
		# create speed, direction, and texture, etc. of projectile from base_projectile_entity.tscn
		var new_projectile = projectile_packed_scene.instantiate() as BaseProjectileEntity
		
		new_projectile.set_direction((mouse_position - global_position).normalized())
		new_projectile.set_speed(TEST_SPEED)
		new_projectile.rotation = new_projectile.direction.angle()
		
		entity_container.add_child(new_projectile)
		
		new_projectile.global_position = primary_weapon_anchor.global_position
